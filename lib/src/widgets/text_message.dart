import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/src/models/message.dart';
import 'package:flutter_chat_ui/src/widgets/inherited_user.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key key,
    this.message,
  })  : assert(message != null),
        super(key: key);

  final TextMessageModel message;

  @override
  Widget build(BuildContext context) {
    final _user = InheritedUser.of(context).user;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: Text(
        message.text,
        style: TextStyle(
          color:
              _user.id == message.authorId ? Colors.white : Color(0xff2e2c2c),
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.25,
        ),
        textWidthBasis: TextWidthBasis.longestLine,
      ),
    );
  }
}
