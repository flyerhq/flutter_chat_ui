import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:provider/provider.dart';

/// Theme values for [FlyerChatTextMessage].
typedef _LocalTheme =
    ({
      TextStyle bodyMedium,
      TextStyle labelSmall,
      Color onPrimary,
      Color onSurface,
      Color primary,
      BorderRadiusGeometry shape,
      Color surfaceContainer,
    });

/// A widget that displays a regular text message.
///
/// Supports markdown rendering via [GptMarkdown].
class FlyerChatTextMessage extends StatelessWidget {
  /// The text message data model.
  final TextMessage message;

  /// The index of the message in the list.
  final int index;

  /// Padding around the message bubble content.
  final EdgeInsetsGeometry? padding;

  /// Border radius of the message bubble.
  final BorderRadiusGeometry? borderRadius;

  /// Box constraints for the message bubble.
  final BoxConstraints? constraints;

  /// Font size for messages containing only emojis.
  final double? onlyEmojiFontSize;

  /// Background color for messages sent by the current user.
  final Color? sentBackgroundColor;

  /// Background color for messages received from other users.
  final Color? receivedBackgroundColor;

  /// Text style for messages sent by the current user.
  final TextStyle? sentTextStyle;

  /// Text style for messages received from other users.
  final TextStyle? receivedTextStyle;

  /// Text style for the message timestamp and status.
  final TextStyle? timeStyle;

  /// Whether to display the message timestamp.
  final bool showTime;

  /// Whether to display the message status (sent, delivered, seen) for sent messages.
  final bool showStatus;

  /// Position of the timestamp and status indicator relative to the text.
  final TimeAndStatusPosition timeAndStatusPosition;

  /// Insets for the timestamp and status indicator when [timeAndStatusPosition] is [TimeAndStatusPosition.inline].
  final EdgeInsetsGeometry? timeAndStatusPositionInlineInsets;

  /// The callback function to handle link clicks.
  final void Function(String url, String title)? onLinkTab;

  /// The position of the link preview widget relative to the text.
  /// If set to [LinkPreviewPosition.none], the link preview widget will not be displayed.
  /// A [LinkPreviewBuilder] must be provided for the preview to be displayed.
  final LinkPreviewPosition linkPreviewPosition;

  /// Creates a widget to display a text message.
  const FlyerChatTextMessage({
    super.key,
    required this.message,
    required this.index,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    this.borderRadius,
    this.constraints,
    this.onlyEmojiFontSize = 48,
    this.sentBackgroundColor,
    this.receivedBackgroundColor,
    this.sentTextStyle,
    this.receivedTextStyle,
    this.timeStyle,
    this.showTime = true,
    this.showStatus = true,
    this.timeAndStatusPosition = TimeAndStatusPosition.end,
    this.timeAndStatusPositionInlineInsets = const EdgeInsets.only(bottom: 2),
    this.onLinkTab,
    this.linkPreviewPosition = LinkPreviewPosition.bottom,
  });

  bool get _isOnlyEmoji => message.metadata?['isOnlyEmoji'] == true;

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
    final isSentByMe = context.read<UserID>() == message.authorId;
    final backgroundColor = _resolveBackgroundColor(isSentByMe, theme);
    final paragraphStyle = _resolveParagraphStyle(isSentByMe, theme);
    final timeStyle = _resolveTimeStyle(isSentByMe, theme);

    final timeAndStatus =
        showTime || (isSentByMe && showStatus)
            ? TimeAndStatus(
              time: message.time,
              status: message.status,
              showTime: showTime,
              showStatus: isSentByMe && showStatus,
              textStyle: timeStyle,
            )
            : null;

    final textContent = GptMarkdown(
      message.text,
      style:
          _isOnlyEmoji
              ? paragraphStyle?.copyWith(fontSize: onlyEmojiFontSize)
              : paragraphStyle,
      onLinkTab: onLinkTab,
    );

    final linkPreviewWidget =
        linkPreviewPosition != LinkPreviewPosition.none
            ? context.read<Builders>().linkPreviewBuilder?.call(
              context,
              message,
            )
            : null;

    return ClipRRect(
      borderRadius: borderRadius ?? theme.shape,
      child: Container(
        constraints: constraints,
        decoration: _isOnlyEmoji ? null : BoxDecoration(color: backgroundColor),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (linkPreviewWidget != null &&
                linkPreviewPosition == LinkPreviewPosition.top)
              linkPreviewWidget,
            Container(
              padding:
                  _isOnlyEmoji
                      ? EdgeInsets.symmetric(
                        horizontal: (padding?.horizontal ?? 0) / 2,
                        vertical: 0,
                      )
                      : padding,
              child: _buildContentBasedOnPosition(
                context: context,
                textContent: textContent,
                timeAndStatus: timeAndStatus,
                paragraphStyle: paragraphStyle,
              ),
            ),
            if (linkPreviewWidget != null &&
                linkPreviewPosition == LinkPreviewPosition.bottom)
              linkPreviewWidget,
          ],
        ),
      ),
    );
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

    switch (timeAndStatusPosition) {
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
            Padding(
              padding: timeAndStatusPositionInlineInsets ?? EdgeInsets.zero,
              child: timeAndStatus,
            ),
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
      return sentBackgroundColor ?? theme.primary;
    }
    return receivedBackgroundColor ?? theme.surfaceContainer;
  }

  TextStyle? _resolveParagraphStyle(bool isSentByMe, _LocalTheme theme) {
    if (isSentByMe) {
      return sentTextStyle ?? theme.bodyMedium.copyWith(color: theme.onPrimary);
    }
    return receivedTextStyle ??
        theme.bodyMedium.copyWith(color: theme.onSurface);
  }

  TextStyle? _resolveTimeStyle(bool isSentByMe, _LocalTheme theme) {
    if (isSentByMe) {
      return timeStyle ??
          theme.labelSmall.copyWith(
            color: _isOnlyEmoji ? theme.onSurface : theme.onPrimary,
          );
    }
    return timeStyle ?? theme.labelSmall.copyWith(color: theme.onSurface);
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
    final timeFormat = context.read<DateFormat>();

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
