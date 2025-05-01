import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:provider/provider.dart';

class FlyerChatTextMessage extends StatelessWidget {
  final TextMessage message;
  final int index;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final double? onlyEmojiFontSize;
  final Color? sentBackgroundColor;
  final Color? receivedBackgroundColor;
  final TextStyle? sentTextStyle;
  final TextStyle? receivedTextStyle;
  final TextStyle? timeStyle;
  final bool showTime;
  final bool showStatus;
  final TimeAndStatusPosition timeAndStatusPosition;

  const FlyerChatTextMessage({
    super.key,
    required this.message,
    required this.index,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    this.borderRadius,
    this.onlyEmojiFontSize = 48,
    this.sentBackgroundColor,
    this.receivedBackgroundColor,
    this.sentTextStyle,
    this.receivedTextStyle,
    this.timeStyle,
    this.showTime = true,
    this.showStatus = true,
    this.timeAndStatusPosition = TimeAndStatusPosition.end,
  });

  bool get _isOnlyEmoji => message.metadata?['isOnlyEmoji'] == true;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ChatTheme>();
    final isSentByMe = context.watch<UserID>() == message.authorId;
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
    );

    return Container(
      padding:
          _isOnlyEmoji
              ? EdgeInsets.symmetric(
                horizontal: (padding?.horizontal ?? 0) / 2,
                vertical: 0,
              )
              : padding,
      decoration:
          _isOnlyEmoji
              ? null
              : BoxDecoration(
                color: backgroundColor,
                borderRadius: borderRadius ?? theme.shape,
              ),
      child: _buildContentBasedOnPosition(
        context: context,
        textContent: textContent,
        timeAndStatus: timeAndStatus,
        paragraphStyle: paragraphStyle,
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

  Color? _resolveBackgroundColor(bool isSentByMe, ChatTheme theme) {
    if (isSentByMe) {
      return sentBackgroundColor ?? theme.colors.primary;
    }
    return receivedBackgroundColor ?? theme.colors.surfaceContainer;
  }

  TextStyle? _resolveParagraphStyle(bool isSentByMe, ChatTheme theme) {
    if (isSentByMe) {
      return sentTextStyle ??
          theme.typography.bodyMedium.copyWith(color: theme.colors.onPrimary);
    }
    return receivedTextStyle ??
        theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface);
  }

  TextStyle? _resolveTimeStyle(bool isSentByMe, ChatTheme theme) {
    if (isSentByMe) {
      return timeStyle ??
          theme.typography.labelSmall.copyWith(
            color:
                _isOnlyEmoji ? theme.colors.onSurface : theme.colors.onPrimary,
          );
    }
    return timeStyle ??
        theme.typography.labelSmall.copyWith(color: theme.colors.onSurface);
  }
}

extension on TextStyle {
  double get lineHeight => (height ?? 1) * (fontSize ?? 0);
}

class TimeAndStatus extends StatelessWidget {
  final DateTime? time;
  final MessageStatus? status;
  final bool showTime;
  final bool showStatus;
  final TextStyle? textStyle;

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
