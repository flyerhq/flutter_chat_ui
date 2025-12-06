import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

/// Theme values for [SimpleTextMessage].
typedef _LocalTheme = ({
  TextStyle bodyMedium,
  TextStyle labelSmall,
  Color onPrimary,
  Color onSurface,
  Color primary,
  BorderRadiusGeometry shape,
  Color surfaceContainer,
});

/// A widget that displays a simple text message.
class SimpleTextMessage extends StatelessWidget {
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

  /// The position of the link preview widget relative to the text.
  /// If set to [LinkPreviewPosition.none], the link preview widget will not be displayed.
  /// A [LinkPreviewBuilder] must be provided for the preview to be displayed.
  final LinkPreviewPosition linkPreviewPosition;

  /// The widget to display on top of the message.
  final Widget? topWidget;

  /// Creates a widget to display a simple text message.
  const SimpleTextMessage({
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
    this.linkPreviewPosition = LinkPreviewPosition.bottom,
    this.topWidget,
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
    final textStyle = _resolveTextStyle(isSentByMe, theme);
    final timeStyle = _resolveTimeStyle(isSentByMe, theme);

    final timeAndStatus = showTime || (isSentByMe && showStatus)
        ? TimeAndStatus(
            time: message.resolvedTime,
            status: message.resolvedStatus,
            showTime: showTime,
            showStatus: isSentByMe && showStatus,
            textStyle: timeStyle,
          )
        : null;

    final textContent = Text(
      message.text,
      style: _isOnlyEmoji
          ? textStyle?.copyWith(fontSize: onlyEmojiFontSize)
          : textStyle,
    );

    final linkPreviewWidget = linkPreviewPosition != LinkPreviewPosition.none
        ? context.read<Builders>().linkPreviewBuilder?.call(
            context,
            message,
            isSentByMe,
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
            Container(
              padding: _isOnlyEmoji
                  ? EdgeInsets.symmetric(
                      horizontal: (padding?.horizontal ?? 0) / 2,
                      vertical: 0,
                    )
                  : padding,
              child: _buildContentBasedOnPosition(
                context: context,
                textContent: textContent,
                timeAndStatus: timeAndStatus,
                textStyle: textStyle,
                linkPreviewWidget: linkPreviewWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentBasedOnPosition({
    required BuildContext context,
    required Widget textContent,
    TimeAndStatus? timeAndStatus,
    TextStyle? textStyle,
    Widget? linkPreviewWidget,
  }) {
    final textDirection = Directionality.of(context);
    final effectiveLinkPreviewPosition = linkPreviewWidget != null
        ? linkPreviewPosition
        : LinkPreviewPosition.none;

    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (topWidget != null) topWidget!,
            if (effectiveLinkPreviewPosition == LinkPreviewPosition.top)
              linkPreviewWidget!,
            timeAndStatusPosition == TimeAndStatusPosition.inline
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(child: textContent),
                      SizedBox(width: 4),
                      Padding(
                        padding:
                            timeAndStatusPositionInlineInsets ??
                            EdgeInsets.zero,
                        child: timeAndStatus,
                      ),
                    ],
                  )
                : textContent,
            if (effectiveLinkPreviewPosition == LinkPreviewPosition.bottom)
              linkPreviewWidget!,
            if (timeAndStatusPosition != TimeAndStatusPosition.inline)
              // Ensure the  width is not smaller than the timeAndStatus widget
              // Ensure the height accounts for it's height
              Opacity(opacity: 0, child: timeAndStatus),
          ],
        ),
        if (timeAndStatusPosition != TimeAndStatusPosition.inline &&
            timeAndStatus != null)
          Positioned.directional(
            textDirection: textDirection,
            end: timeAndStatusPosition == TimeAndStatusPosition.end ? 0 : null,
            start: timeAndStatusPosition == TimeAndStatusPosition.start
                ? 0
                : null,
            bottom: 0,
            child: timeAndStatus,
          ),
      ],
    );
  }

  Color? _resolveBackgroundColor(bool isSentByMe, _LocalTheme theme) {
    if (isSentByMe) {
      return sentBackgroundColor ?? theme.primary;
    }
    return receivedBackgroundColor ?? theme.surfaceContainer;
  }

  TextStyle? _resolveTextStyle(bool isSentByMe, _LocalTheme theme) {
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
