import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'stream_state.dart';
import 'text_segment.dart';

/// Theme values for [FlyerChatTextStreamMessage].
typedef _LocalTheme = ({
  TextStyle bodyMedium,
  TextStyle labelSmall,
  Color onPrimary,
  Color onSurface,
  Color primary,
  BorderRadiusGeometry shape,
  Color surfaceContainer,
});

/// Defines how the text stream message content is rendered.
enum TextStreamMessageMode {
  /// Renders text using [RichText] with per-chunk fade-in animations.
  ///
  /// This provides a dynamic visual effect as text arrives.
  animatedOpacity,

  /// Renders the entire accumulated text using [GptMarkdown] instantly on each update.
  ///
  /// This ensures rendering consistency with the final `TextMessage` (if it also
  /// uses Markdown), but lacks the chunk-by-chunk animation.
  instantMarkdown,
}

/// A widget that displays a text message which is being streamed incrementally.
///
/// This widget expects a [TextStreamMessage] and the current [StreamState]
/// (managed externally) to render the incoming text dynamically.
///
/// It supports two rendering modes via [TextStreamMessageMode]:
/// - `animatedOpacity`: Fades in each new chunk of text.
/// - `instantMarkdown`: Renders the full accumulated text with Markdown on each update.
class FlyerChatTextStreamMessage extends StatefulWidget {
  /// The underlying `TextStreamMessage` data model.
  final TextStreamMessage message;

  /// The index of the message in the list.
  final int index;

  /// The current state of the stream, determining what to display (loading,
  /// streaming text, completed text, error).
  final StreamState streamState;

  /// Padding around the message bubble content.
  final EdgeInsetsGeometry? padding;

  /// Border radius of the message bubble.
  final BorderRadiusGeometry? borderRadius;

  /// Background color for messages sent by the current user.
  final Color? sentBackgroundColor;

  /// Background color for messages received from other users.
  final Color? receivedBackgroundColor;

  /// Text style for messages sent by the current user.
  final TextStyle? sentTextStyle;

  /// Text style for messages received from other users.
  final TextStyle? receivedTextStyle;

  /// Text style for the message timestamp.
  final TextStyle? timeStyle;

  /// Whether to display the message timestamp.
  final bool showTime;

  /// Whether to display the message status (sent, delivered, seen) for sent messages.
  final bool showStatus;

  /// Position of the timestamp and status indicator relative to the text.
  final TimeAndStatusPosition timeAndStatusPosition;

  /// Duration for the fade-in animation of each text chunk when
  /// `mode` is [TextStreamMessageMode.animatedOpacity].
  final Duration chunkAnimationDuration;

  /// The rendering mode for the text content.
  final TextStreamMessageMode mode;

  /// The callback function to handle link clicks.
  final void Function(String url, String title)? onLinkTap;

  /// The text to display while in the loading state. Defaults to "Thinking".
  final String loadingText;

  /// The base color for the shimmer loading animation.
  final Color? shimmerBaseColor;

  /// The highlight color for the shimmer loading animation.
  final Color? shimmerHighlightColor;

  /// The period of the shimmer loading animation.
  final Duration shimmerPeriod;

  /// A builder to completely override the default loading widget.
  /// If provided, `loadingText`, `shimmerBaseColor`, and `shimmerHighlightColor` are ignored.
  final Widget Function(BuildContext context, TextStyle? paragraphStyle)?
  loadingBuilder;

  /// Creates a widget to display a streaming text message.
  const FlyerChatTextStreamMessage({
    super.key,
    required this.message,
    required this.index,
    required this.streamState,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    this.borderRadius,
    this.sentBackgroundColor,
    this.receivedBackgroundColor,
    this.sentTextStyle,
    this.receivedTextStyle,
    this.timeStyle,
    this.showTime = true,
    this.showStatus = true,
    this.timeAndStatusPosition = TimeAndStatusPosition.end,
    this.chunkAnimationDuration = const Duration(milliseconds: 350),
    this.mode = TextStreamMessageMode.animatedOpacity,
    this.onLinkTap,
    this.loadingText = 'Thinking',
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
    this.shimmerPeriod = const Duration(milliseconds: 1000),
    this.loadingBuilder,
  });

  @override
  State<FlyerChatTextStreamMessage> createState() =>
      _FlyerChatTextStreamMessageState();
}

class _FlyerChatTextStreamMessageState extends State<FlyerChatTextStreamMessage>
    with TickerProviderStateMixin {
  List<TextSegment> _segments = [];

  @override
  void initState() {
    super.initState();
    _updateSegmentsFromState(widget.streamState, isInitial: true);
  }

  @override
  void dispose() {
    _disposeAllSegmentControllers();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FlyerChatTextStreamMessage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.streamState == oldWidget.streamState) return;

    _updateSegmentsFromState(
      widget.streamState,
      oldState: oldWidget.streamState,
    );
  }

  void _updateSegmentsFromState(
    StreamState newState, {
    StreamState? oldState,
    bool isInitial = false,
  }) {
    if (isInitial) {
      _disposeAllSegmentControllers();

      var initialText = '';
      if (newState is StreamStateStreaming) {
        initialText = newState.accumulatedText;
      } else if (newState is StreamStateCompleted) {
        initialText = newState.finalText;
      } else if (newState is StreamStateError) {
        initialText = newState.accumulatedText ?? '';
      }

      _segments = [if (initialText.isNotEmpty) StaticSegment(initialText)];
    } else {
      if (newState is StreamStateStreaming) {
        final newText = newState.accumulatedText;
        final currentSegmentText = _segments.map((s) => s.text).join('');

        if (newText.length > currentSegmentText.length &&
            newText.startsWith(currentSegmentText)) {
          final newChunk = newText.substring(currentSegmentText.length);

          _addNewAnimatingChunk(newChunk);
        } else if (newText != currentSegmentText) {
          _disposeAllSegmentControllers();
          setState(() {
            _segments = [if (newText.isNotEmpty) StaticSegment(newText)];
          });
        }
      } else {
        // Transitioning to a final state (Completed, Error, or back to Loading)
        _disposeAllSegmentControllers();

        var finalText = '';
        if (newState is StreamStateCompleted) {
          finalText = newState.finalText;
        } else if (newState is StreamStateError) {
          finalText = newState.accumulatedText ?? '';
        }

        // Reconstruct the full string currently represented by all segments.
        final currentText = _segments.map((s) => s.text).join('');

        // Update the UI only if necessary:
        // 1. If the final text differs from the text currently shown (including partially animated parts).
        // 2. OR if there are still segments animating (even if text matches, animations need removal).
        if (finalText != currentText ||
            _segments.any((s) => s is AnimatingSegment)) {
          setState(() {
            // Replace all existing segments with a single StaticSegment containing the final text.
            // This ensures any leftover animations are stopped and the correct final content is displayed.
            _segments = [if (finalText.isNotEmpty) StaticSegment(finalText)];
          });
        }
      }
    }
  }

  void _addNewAnimatingChunk(String chunk) {
    final controller = AnimationController(
      duration: widget.chunkAnimationDuration,
      vsync: this,
    );
    final fadeAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInToLinear,
    );

    final newSegment = AnimatingSegment(chunk, controller, fadeAnimation);

    // Add listener to trigger setState on animation ticks
    // ignore: prefer_function_declarations_over_variables
    final listener = () {
      if (mounted) {
        setState(() {});
      }
    };

    controller.addListener(listener);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.removeListener(listener);
        _finalizeChunkAnimation(newSegment);
      }
    });

    setState(() {
      _segments.add(newSegment);
    });

    controller.forward(from: 0);
  }

  void _disposeAllSegmentControllers() {
    for (final segment in _segments) {
      if (segment is AnimatingSegment) {
        // Disposing the AnimationController also automatically removes its listeners.
        // While explicitly calling controller.removeListener(listener) before dispose()
        // is the most defensive approach, it requires storing the listener reference
        // within the AnimatingSegment, adding complexity. Relying on dispose() is standard
        // practice and sufficient here.
        segment.dispose();
      }
    }
  }

  void _finalizeChunkAnimation(AnimatingSegment completedSegment) {
    if (!mounted) return;
    setState(() {
      final index = _segments.indexOf(completedSegment);
      if (index != -1) {
        // Replace animating segment with static segment
        _segments[index] = StaticSegment(completedSegment.text);
        // No need to remove listener explicitly here if controller is disposed
        completedSegment.dispose();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.select(
      (ChatTheme t) => (
        bodyMedium: t.typography.bodyMedium,
        labelSmall: t.typography.labelSmall,
        onPrimary: t.colors.onPrimary,
        onSurface: t.colors.onSurface,
        primary: t.colors.primary,
        shape: t.shape,
        surfaceContainer: t.colors.surfaceContainer,
      ),
    );
    final isSentByMe = context.read<UserID>() == widget.message.authorId;
    final backgroundColor = _resolveBackgroundColor(isSentByMe, theme);
    final paragraphStyle = _resolveParagraphStyle(isSentByMe, theme);
    final timeStyle = _resolveTimeStyle(isSentByMe, theme);

    final timeAndStatus = widget.showTime || (isSentByMe && widget.showStatus)
        ? TimeAndStatus(
            time: widget.message.resolvedTime,
            status: widget.message.resolvedStatus,
            showTime: widget.showTime,
            showStatus: isSentByMe && widget.showStatus,
            textStyle: timeStyle,
          )
        : null;

    // Build text content based on segments
    final textContent = _buildTextContent(paragraphStyle, theme);

    // Build the message container and layout
    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: widget.borderRadius ?? theme.shape,
      ),
      child: _buildContentBasedOnPosition(
        context: context,
        textContent: textContent,
        timeAndStatus: timeAndStatus,
        paragraphStyle: paragraphStyle,
      ),
    );
  }

  Widget _buildTextContent(TextStyle? paragraphStyle, _LocalTheme theme) {
    if (widget.streamState is StreamStateLoading) {
      if (widget.loadingBuilder != null) {
        return widget.loadingBuilder!(context, paragraphStyle);
      }

      return Shimmer.fromColors(
        baseColor:
            widget.shimmerBaseColor ?? theme.onSurface.withValues(alpha: 0.3),
        highlightColor:
            widget.shimmerHighlightColor ??
            theme.onSurface.withValues(alpha: 0.8),
        period: widget.shimmerPeriod,
        child: Text(widget.loadingText, style: paragraphStyle),
      );
    }

    if (widget.streamState is StreamStateError) {
      final state = widget.streamState as StreamStateError;
      final errorText = state.accumulatedText != null
          ? '${state.accumulatedText}\n\nError: ${state.error}'
          : 'Error: ${state.error}';
      return Text(
        errorText,
        style: paragraphStyle?.copyWith(color: Colors.red),
      );
    }

    if (widget.streamState is StreamStateCompleted) {
      final state = widget.streamState as StreamStateCompleted;
      return GptMarkdown(
        state.finalText,
        style: paragraphStyle,
        onLinkTap: widget.onLinkTap,
      );
    }

    // Build RichText from segments for Streaming state
    if (widget.streamState is StreamStateStreaming) {
      if (_segments.isEmpty) {
        // Show placeholder if streaming hasn't produced any segments yet
        return Text(
          '...',
          style: paragraphStyle?.copyWith(
            color: paragraphStyle.color?.withValues(alpha: 0.5),
          ),
        );
      }

      if (widget.mode == TextStreamMessageMode.instantMarkdown) {
        final combinedText = _segments.map((s) => s.text).join('');
        return GptMarkdown(combinedText, style: paragraphStyle);
      } else {
        return RichText(
          text: TextSpan(
            style: paragraphStyle,
            children: _segments.map<InlineSpan>((segment) {
              if (segment is StaticSegment) {
                return TextSpan(text: segment.text);
              } else if (segment is AnimatingSegment) {
                final currentOpacity = segment.fadeAnimation.value;
                final animatingStyle = paragraphStyle?.copyWith(
                  color: paragraphStyle.color?.withValues(
                    alpha: currentOpacity,
                  ),
                );
                return TextSpan(text: segment.text, style: animatingStyle);
              }
              return const TextSpan();
            }).toList(),
          ),
        );
      }
    }

    return const SizedBox.shrink();
  }

  Widget _buildContentBasedOnPosition({
    required BuildContext context,
    required Widget textContent,
    TimeAndStatus? timeAndStatus,
    TextStyle? paragraphStyle,
  }) {
    if (timeAndStatus == null) {
      return textContent;
    }

    final textDirection = Directionality.of(context);

    switch (widget.timeAndStatusPosition) {
      case TimeAndStatusPosition.start:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [textContent, timeAndStatus],
        );
      case TimeAndStatusPosition.inline:
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(child: textContent),
            const SizedBox(width: 4),
            timeAndStatus,
          ],
        );
      case TimeAndStatusPosition.end:
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: paragraphStyle?.lineHeight ?? 0),
              child: textContent,
            ),
            Opacity(opacity: 0, child: timeAndStatus),
            Positioned.directional(
              textDirection: textDirection,
              end: 0,
              bottom: 0,
              child: timeAndStatus,
            ),
          ],
        );
    }
  }

  Color? _resolveBackgroundColor(bool isSentByMe, _LocalTheme theme) {
    if (isSentByMe) {
      return widget.sentBackgroundColor ?? theme.primary;
    }
    return widget.receivedBackgroundColor ?? theme.surfaceContainer;
  }

  TextStyle? _resolveParagraphStyle(bool isSentByMe, _LocalTheme theme) {
    if (isSentByMe) {
      return widget.sentTextStyle ??
          theme.bodyMedium.copyWith(color: theme.onPrimary);
    }
    return widget.receivedTextStyle ??
        theme.bodyMedium.copyWith(color: theme.onSurface);
  }

  TextStyle? _resolveTimeStyle(bool isSentByMe, _LocalTheme theme) {
    if (isSentByMe) {
      return widget.timeStyle ??
          theme.labelSmall.copyWith(color: theme.onPrimary);
    }
    return widget.timeStyle ??
        theme.labelSmall.copyWith(color: theme.onSurface);
  }
}

/// Internal extension for calculating the visual line height of a TextStyle.
extension on TextStyle {
  /// Calculates the line height based on the style's `height` and `fontSize`.
  double get lineHeight => (height ?? 1) * (fontSize ?? 0);
}

/// A widget to display the message timestamp and status indicator.
class TimeAndStatus extends StatelessWidget {
  /// The time the message was created.
  final DateTime? time;

  /// The status of the message.
  final MessageStatus? status;

  /// Whether to display the timestamp.
  final bool showTime;

  /// Whether to display the status indicator.
  final bool showStatus;

  /// The text style for the time and status.
  final TextStyle? textStyle;

  /// Creates a widget for displaying time and status.
  const TimeAndStatus({
    super.key,
    required this.time,
    this.status,
    this.showTime = true,
    this.showStatus = true,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final timeFormat = context.watch<DateFormat>();

    return Row(
      spacing: 2,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showTime && time != null)
          Text(timeFormat.format(time!.toLocal()), style: textStyle),
        if (showStatus && status != null)
          if (status == MessageStatus.sending)
            SizedBox(
              width: 6,
              height: 6,
              child: CircularProgressIndicator(
                color: textStyle?.color,
                strokeWidth: 2,
              ),
            )
          else
            Icon(getIconForStatus(status!), color: textStyle?.color, size: 12),
      ],
    );
  }
}
