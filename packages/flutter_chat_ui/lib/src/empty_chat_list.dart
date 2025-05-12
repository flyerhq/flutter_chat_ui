import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

class EmptyChatList extends StatelessWidget {
  const EmptyChatList({
    super.key,
    this.text = 'No messages yet',
    this.textStyle,
  });

  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ChatTheme>();
    return Center(
      child: Text(text, style: textStyle ?? theme.typography.bodyLarge),
    );
  }
}
