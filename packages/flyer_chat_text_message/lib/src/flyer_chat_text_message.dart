import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:provider/provider.dart';

class FlyerChatTextMessage extends StatelessWidget {
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

  const FlyerChatTextMessage({
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
  });

  bool get _isOnlyEmoji => message.isOnlyEmoji == true;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ChatTheme>();
    final isSentByMe = context.watch<String>() == message.authorId;
    final backgroundColor = _resolveBackgroundColor(isSentByMe, theme);
    final paragraphStyle = _resolveParagraphStyle(isSentByMe, theme);

    return Container(
      padding: padding,
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
      child: GptMarkdown(
        message.text,
        style:
            _isOnlyEmoji
                ? paragraphStyle?.copyWith(fontSize: onlyEmojiFontSize)
                : paragraphStyle,
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

  TextStyle? _resolveParagraphStyle(bool isSentByMe, ChatTheme theme) {
    if (isSentByMe) {
      return sentTextStyle == _sentinelTextStyle
          ? theme.typography.bodyMedium.copyWith(color: theme.colors.onPrimary)
          : sentTextStyle;
    }
    return receivedTextStyle == _sentinelTextStyle
        ? theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface)
        : receivedTextStyle;
  }
}
