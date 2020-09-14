import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/src/models/message.dart';
import 'package:flutter_chat_ui/src/models/user.dart';
import 'package:flutter_chat_ui/src/widgets/inherited_user.dart';
import 'package:flutter_chat_ui/src/widgets/input.dart';
import 'package:flutter_chat_ui/src/widgets/message.dart';

class Chat extends StatefulWidget {
  Chat({
    Key key,
    @required this.messages,
    @required this.onSendPressed,
    @required this.user,
  })  : assert(messages != null),
        assert(onSendPressed != null),
        assert(user != null),
        super(key: key);

  final List<MessageModel> messages;
  final void Function(TextMessageModel) onSendPressed;
  final User user;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    final messageWidth =
        min(MediaQuery.of(context).size.width * 0.77, 440).floor();

    return InheritedUser(
      user: widget.user,
      child: Column(
        children: [
          Flexible(
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus.unfocus(),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.messages.length,
                reverse: true,
                itemBuilder: (context, index) {
                  MessageModel message = widget.messages[index];
                  final previousMessageSameAuthor = index <= 0
                      ? false
                      : widget.messages[index - 1].authorId == message.authorId;

                  return Message(
                    message: message,
                    messageWidth: messageWidth,
                    previousMessageSameAuthor: previousMessageSameAuthor,
                  );
                },
              ),
            ),
          ),
          Input(
            onSendPressed: widget.onSendPressed,
          ),
        ],
      ),
    );
  }
}
