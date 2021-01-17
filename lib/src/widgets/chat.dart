import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/src/util.dart';
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
                    // TODO: Update the logic after pagination is introduced
                    final isFirst = index == 0;
                    final isLast = index == widget.messages.length - 1;
                    final nextMessage =
                        isLast ? null : widget.messages[index + 1];
                    final previousMessage =
                        isFirst ? null : widget.messages[index - 1];

                    bool nextMessageDifferentDay = false;
                    bool nextMessageSameAuthor = false;
                    bool previousMessageSameAuthor = false;
                    bool shouldRenderTime = message.timestamp != null;

                    if (nextMessage != null) {
                      nextMessageDifferentDay = message.timestamp != null &&
                          DateTime.fromMillisecondsSinceEpoch(
                                message.timestamp * 1000,
                              ).day !=
                              DateTime.fromMillisecondsSinceEpoch(
                                nextMessage.timestamp * 1000,
                              ).day;
                      nextMessageSameAuthor =
                          nextMessage.authorId == message.authorId;
                    }

                    if (previousMessage != null) {
                      previousMessageSameAuthor =
                          previousMessage.authorId == message.authorId;
                      shouldRenderTime = message.timestamp != null &&
                          (!previousMessageSameAuthor ||
                              previousMessage.timestamp - message.timestamp >=
                                  60);
                    }

                    return Column(
                      children: [
                        if (nextMessageDifferentDay ||
                            (isLast && message.timestamp != null))
                          Container(
                            margin: EdgeInsets.only(
                              bottom: 32,
                              top: nextMessageSameAuthor ? 24 : 16,
                            ),
                            child: Text(
                              getVerboseDateTimeRepresentation(
                                DateTime.fromMillisecondsSinceEpoch(
                                  message.timestamp * 1000,
                                ),
                              ),
                              style: TextStyle(
                                color: const Color(0xff1d1d21),
                                fontFamily: 'Avenir',
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                height: 1.375,
                              ),
                            ),
                          ),
                        Message(
                          message: message,
                          messageWidth: _messageWidth,
                          onFilePressed: widget.onFilePressed,
                          previousMessageSameAuthor: previousMessageSameAuthor,
                          shouldRenderTime: shouldRenderTime,
                        ),
                      ],
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
