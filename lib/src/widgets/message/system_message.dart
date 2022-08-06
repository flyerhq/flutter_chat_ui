import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../state/inherited_chat_theme.dart';

class SystemMessage extends StatelessWidget {
  const SystemMessage({
    super.key,
    required this.message,
  });

  final types.Message message; // TODO: replace with SystemMessage.

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        margin: InheritedChatTheme.of(context).theme.systemMessageTheme.margin,
        child: Text(
          'Matthew joined the chat', // TODO: replace with SystemMessage text.
          style:
              InheritedChatTheme.of(context).theme.systemMessageTheme.textStyle,
        ),
      );
}

@immutable
class SystemMessageTheme {
  const SystemMessageTheme({
    required this.margin,
    required this.textStyle,
  });

  /// Margin around the system message.
  final EdgeInsets margin;

  /// Text style for the unseen message banner text.
  final TextStyle textStyle;
}
