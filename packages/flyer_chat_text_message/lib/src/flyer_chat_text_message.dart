import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

class FlyerChatTextMessage extends StatelessWidget {
  final TextMessage message;
  final int index;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final double? onlyEmojiFontSize;

  const FlyerChatTextMessage({
    super.key,
    required this.message,
    required this.index,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 10,
    ),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.onlyEmojiFontSize = 48,
  });

  @override
  Widget build(BuildContext context) {
    final textMessageTheme =
        context.select((ChatTheme theme) => theme.textMessageTheme);
    final isSentByMe = context.watch<String>() == message.authorId;
    final paragraphStyle = isSentByMe
        ? textMessageTheme.sentTextStyle
        : textMessageTheme.receivedTextStyle;

    return Container(
      padding: padding,
      decoration: message.isOnlyEmoji == true
          ? null
          : BoxDecoration(
              color: isSentByMe
                  ? textMessageTheme.sentBackgroundColor
                  : textMessageTheme.receivedBackgroundColor,
              borderRadius: borderRadius,
            ),
      child: MarkdownBody(
        data: message.text,
        styleSheet: MarkdownStyleSheet(
          p: message.isOnlyEmoji == true
              ? paragraphStyle?.copyWith(fontSize: onlyEmojiFontSize)
              : paragraphStyle,
        ),
      ),
    );
  }
}
