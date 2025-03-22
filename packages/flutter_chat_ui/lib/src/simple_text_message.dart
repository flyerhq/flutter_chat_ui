import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

class SimpleTextMessage extends StatelessWidget {
  static const BorderRadiusGeometry _sentinelBorderRadius = BorderRadius.zero;
  static const Color _sentinelColor = Colors.transparent;
  static const TextStyle _sentinelTextStyle = TextStyle();

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
  final String? time;

  const SimpleTextMessage({
    super.key,
    required this.message,
    required this.index,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    this.borderRadius = _sentinelBorderRadius,
    this.onlyEmojiFontSize = 48,
    this.sentBackgroundColor = _sentinelColor,
    this.receivedBackgroundColor = _sentinelColor,
    this.sentTextStyle = _sentinelTextStyle,
    this.receivedTextStyle = _sentinelTextStyle,
    this.timeStyle = _sentinelTextStyle,
    this.time,
  });

  bool get _isOnlyEmoji => message.isOnlyEmoji == true;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ChatTheme>();
    final isSentByMe = context.watch<String>() == message.authorId;
    final backgroundColor = _resolveBackgroundColor(isSentByMe, theme);
    final textStyle = _resolveTextStyle(isSentByMe, theme);
    final timeStyle = _resolveTimeStyle(isSentByMe, theme);

    final timeWidget = time != null ? Text(time!, style: timeStyle) : null;

    final textContent = Text(
      message.text,
      style:
          _isOnlyEmoji
              ? textStyle?.copyWith(fontSize: onlyEmojiFontSize)
              : textStyle,
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
                borderRadius:
                    borderRadius == _sentinelBorderRadius
                        ? theme.shape
                        : borderRadius,
              ),
      child: Stack(
        children: [
          timeWidget != null
              ? Padding(
                padding: EdgeInsets.only(bottom: textStyle?.lineHeight ?? 0),
                child: textContent,
              )
              : textContent,
          if (timeWidget != null) ...[
            Opacity(opacity: 0, child: timeWidget),
            Positioned(right: 0, bottom: 0, child: timeWidget),
          ],
        ],
      ),
    );
  }

  Color? _resolveBackgroundColor(bool isSentByMe, ChatTheme theme) {
    if (isSentByMe) {
      return sentBackgroundColor == _sentinelColor
          ? theme.colors.primary
          : sentBackgroundColor;
    }
    return receivedBackgroundColor == _sentinelColor
        ? theme.colors.surfaceContainer
        : receivedBackgroundColor;
  }

  TextStyle? _resolveTextStyle(bool isSentByMe, ChatTheme theme) {
    if (isSentByMe) {
      return sentTextStyle == _sentinelTextStyle
          ? theme.typography.bodyMedium.copyWith(color: theme.colors.onPrimary)
          : sentTextStyle;
    }
    return receivedTextStyle == _sentinelTextStyle
        ? theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface)
        : receivedTextStyle;
  }

  TextStyle? _resolveTimeStyle(bool isSentByMe, ChatTheme theme) {
    if (isSentByMe) {
      return timeStyle == _sentinelTextStyle
          ? theme.typography.labelSmall.copyWith(
            color:
                _isOnlyEmoji ? theme.colors.onSurface : theme.colors.onPrimary,
          )
          : timeStyle;
    }
    return timeStyle == _sentinelTextStyle
        ? theme.typography.labelSmall.copyWith(color: theme.colors.onSurface)
        : timeStyle;
  }
}

extension on TextStyle {
  double get lineHeight => (height ?? 1) * (fontSize ?? 0);
}
