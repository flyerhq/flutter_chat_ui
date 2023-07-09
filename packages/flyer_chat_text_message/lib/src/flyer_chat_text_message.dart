import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

class FlyerChatTextMessage extends StatelessWidget {
  final TextMessage message;

  const FlyerChatTextMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final textMessageTheme =
        context.select((ChatTheme theme) => theme.textMessageTheme);
    final isSentByMe = context.watch<User>().id == message.author.id;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: isSentByMe
            ? textMessageTheme.sentBackgroundColor
            : textMessageTheme.receivedBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: MarkdownBody(
        data: message.text,
        styleSheet: MarkdownStyleSheet(
          p: isSentByMe
              ? textMessageTheme.sentTextStyle
              : textMessageTheme.receivedTextStyle,
        ),
      ),
    );
  }
}
