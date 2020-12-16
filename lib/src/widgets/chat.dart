import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/src/widgets/inherited_user.dart';
import 'package:flutter_chat_ui/src/widgets/input.dart';
import 'package:flutter_chat_ui/src/widgets/message.dart';

class Chat extends StatefulWidget {
  const Chat({
    Key key,
    @required this.messages,
    this.onFilePressed,
    @required this.onSendPressed,
    @required this.user,
  })  : assert(messages != null),
        assert(onSendPressed != null),
        assert(user != null),
        super(key: key);

  final List<types.Message> messages;
  final void Function(types.FileMessage) onFilePressed;
  final void Function(types.TextMessage) onSendPressed;
  final types.User user;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    final _messageWidth =
        min(MediaQuery.of(context).size.width * 0.77, 440).floor();

    return InheritedUser(
      user: widget.user,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Flexible(
              child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus.unfocus(),
                child: ListView.builder(
                  itemCount: widget.messages.length + 1,
                  padding: EdgeInsets.zero,
                  reverse: true,
                  itemBuilder: (context, index) {
                    if (index == widget.messages.length) {
                      return Container(height: 16);
                    }

                    final message = widget.messages[index];
                    // Update the logic after pagination is introduced
                    final isFirst = index == 0;
                    final previousMessage =
                        isFirst ? null : widget.messages[index - 1];

                    final previousMessageSameAuthor = previousMessage == null
                        ? false
                        : previousMessage.authorId == message.authorId;

                    return Message(
                      message: message,
                      messageWidth: _messageWidth,
                      onFilePressed: widget.onFilePressed,
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
      ),
    );
  }
}
