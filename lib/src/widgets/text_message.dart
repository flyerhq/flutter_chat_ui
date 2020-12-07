import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/src/widgets/inherited_user.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key key,
    @required this.message,
  })  : assert(message != null),
        super(key: key);

  final types.TextMessage message;

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
          color: _user.id == message.authorId
              ? const Color(0xffffffff)
              : const Color(0xff1d1d21),
          fontFamily: 'Avenir',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.375,
        ),
        textWidthBasis: TextWidthBasis.longestLine,
      ),
    );
  }
}
