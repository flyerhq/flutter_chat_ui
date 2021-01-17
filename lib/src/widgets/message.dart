import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/src/widgets/file_message.dart';
import 'package:flutter_chat_ui/src/widgets/image_message.dart';
import 'package:flutter_chat_ui/src/widgets/inherited_user.dart';
import 'package:flutter_chat_ui/src/widgets/text_message.dart';

class Message extends StatelessWidget {
  const Message({
    Key key,
    @required this.message,
    @required this.messageWidth,
    this.onFilePressed,
    @required this.previousMessageSameAuthor,
    @required this.shouldRenderTime,
  })  : assert(message != null),
        assert(messageWidth != null),
        assert(previousMessageSameAuthor != null),
        assert(shouldRenderTime != null),
        super(key: key);

  final types.Message message;
  final int messageWidth;
  final void Function(types.FileMessage) onFilePressed;
  final bool previousMessageSameAuthor;
  final bool shouldRenderTime;

  Widget _buildMessage() {
    switch (message.type) {
      case types.MessageType.file:
        final types.FileMessage fileMessage = message;
        return FileMessage(
          message: fileMessage,
          onPressed: onFilePressed,
        );
      case types.MessageType.image:
        final types.ImageMessage imageMessage = message;
        return ImageMessage(
          message: imageMessage,
          messageWidth: messageWidth,
          onPressed: (String url) {},
        );
      case types.MessageType.text:
        final types.TextMessage textMessage = message;
        return TextMessage(message: textMessage);
      default:
        return Container();
    }
  }

  Widget _buildStatus() {
    switch (message.status) {
      case types.Status.read:
        return Image.asset(
          'assets/icon-read.png',
          color: const Color(0xff6f61e8),
          package: 'flutter_chat_ui',
        );
      case types.Status.sending:
        return SizedBox(
          height: 12,
          width: 12,
          child: CircularProgressIndicator(
            backgroundColor: Colors.transparent,
            strokeWidth: 2,
            valueColor: new AlwaysStoppedAnimation<Color>(
              Color(0xff6f61e8),
            ),
          ),
        );
      case types.Status.sent:
        return Image.asset(
          'assets/icon-sent.png',
          color: const Color(0xff6f61e8),
          package: 'flutter_chat_ui',
        );
      default:
        return Container();
    }
  }

  Widget _buildTime(bool currentUserIsAuthor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(
            right: currentUserIsAuthor ? 8 : 16,
          ),
          child: Text(
            DateFormat.jm().format(
              DateTime.fromMillisecondsSinceEpoch(
                message.timestamp * 1000,
              ),
            ),
            style: TextStyle(
              color: const Color(0xff9e9cab),
              fontFamily: 'Avenir',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.375,
            ),
          ),
        ),
        if (currentUserIsAuthor) _buildStatus()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _user = InheritedUser.of(context).user;
    final _borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(_user.id == message.authorId ? 20 : 0),
      bottomRight: Radius.circular(_user.id == message.authorId ? 0 : 20),
      topLeft: const Radius.circular(20),
      topRight: const Radius.circular(20),
    );
    final _currentUserIsAuthor = _user.id == message.authorId;

    return Container(
      alignment: _user.id == message.authorId
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: _borderRadius,
                color: !_currentUserIsAuthor ||
                        message.type == types.MessageType.image
                    ? const Color(0xfff7f7f8)
                    : const Color(0xff6f61e8),
              ),
              child: ClipRRect(
                borderRadius: _borderRadius,
                child: _buildMessage(),
              ),
            ),
            if (shouldRenderTime)
              Container(
                margin: EdgeInsets.only(
                  top: 8,
                ),
                child: _buildTime(_currentUserIsAuthor),
              )
          ],
        ),
      ),
    );
  }
}
