import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/src/models/message.dart';
import 'package:flutter_chat_ui/src/widgets/image_message.dart';
import 'package:flutter_chat_ui/src/widgets/inherited_user.dart';
import 'package:flutter_chat_ui/src/widgets/text_message.dart';

class Message extends StatelessWidget {
  const Message({
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
        return ImageMessage(message: imageMessage);
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
    final borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(user.id == message.authorId ? 20 : 0),
      bottomRight: Radius.circular(user.id == message.authorId ? 0 : 20),
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    );

    return Container(
      alignment: user.id == message.authorId
          ? Alignment.centerRight
          : Alignment.centerLeft,
      margin: EdgeInsets.only(
        bottom: previousMessageSameAuthor ? 8 : 16,
        left: 24,
        right: 24,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: messageWidth.toDouble(),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color:
                user.id != message.authorId || message.type == MessageType.image
                    ? Color(0xfff7f7f8)
                    : Color(0xff6054c9),
          ),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: _buildMessage(),
          ),
        ),
      ),
    );
  }
}
