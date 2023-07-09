import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

class SimpleTextMessage extends StatelessWidget {
  final TextMessage message;

  const SimpleTextMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final textMessageTheme =
        context.select((ChatTheme theme) => theme.textMessageTheme);
    final isSentByMe = context.watch<String>() == message.senderId;

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
      child: Text(
        message.text,
        style: isSentByMe
            ? textMessageTheme.sentTextStyle
            : textMessageTheme.receivedTextStyle,
      ),
    );
  }
}
