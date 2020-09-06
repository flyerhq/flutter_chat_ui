import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/src/models/message.dart';
import 'package:flutter_chat_ui/src/widgets/inherited_user.dart';
import 'package:flutter_chat_ui/src/widgets/text_message.dart';

class Message extends StatelessWidget {
  Message({
    Key key,
    this.message,
    this.messageWidth,
    this.previousMessageSameAuthor,
  })  : assert(message != null),
        assert(messageWidth != null),
        assert(previousMessageSameAuthor != null),
        super(key: key);

  final MessageModel message;
  final int messageWidth;
  final bool previousMessageSameAuthor;

  Widget _buildMessage() {
    switch (message.type) {
      case MessageType.image:
        final ImageMessageModel imageMessage = message;
        return Image.network(imageMessage.url);
      case MessageType.text:
        final TextMessageModel textMessage = message;
        return TextMessage(message: textMessage);
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = InheritedUser.of(context).user;

    return Container(
      alignment: message.authorId == user.id
          ? Alignment.centerRight
          : Alignment.centerLeft,
      margin: EdgeInsets.only(
        bottom: previousMessageSameAuthor ? 8 : 24,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: messageWidth.toDouble(),
        ),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Colors.blueAccent,
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: _buildMessage(),
        ),
      ),
    );
  }
}
