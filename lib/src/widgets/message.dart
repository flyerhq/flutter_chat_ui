import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'file_message.dart';
import 'image_message.dart';
import 'inherited_chat_theme.dart';
import 'inherited_user.dart';
import 'text_message.dart';

class Message extends StatelessWidget {
  const Message({
    Key? key,
    this.dateLocale,
    required this.message,
    required this.messageWidth,
    this.onFilePressed,
    required this.onImagePressed,
    this.onPreviewDataFetched,
    required this.previousMessageSameAuthor,
    required this.shouldRenderTime,
  }) : super(key: key);

  final String? dateLocale;
  final types.Message message;
  final int messageWidth;
  final void Function(types.FileMessage)? onFilePressed;
  final void Function(String) onImagePressed;
  final void Function(types.TextMessage, types.PreviewData)?
      onPreviewDataFetched;
  final bool previousMessageSameAuthor;
  final bool shouldRenderTime;

  Widget _buildMessage() {
    switch (message.type) {
      case types.MessageType.file:
        final fileMessage = message as types.FileMessage;
        return FileMessage(
          message: fileMessage,
          onPressed: onFilePressed,
        );
      case types.MessageType.image:
        final imageMessage = message as types.ImageMessage;
        return ImageMessage(
          message: imageMessage,
          messageWidth: messageWidth,
          onPressed: onImagePressed,
        );
      case types.MessageType.text:
        final textMessage = message as types.TextMessage;
        return TextMessage(
          message: textMessage,
          onPreviewDataFetched: onPreviewDataFetched,
        );
      default:
        return Container();
    }
  }

  Widget _buildStatus(BuildContext context) {
    switch (message.status) {
      case types.Status.read:
        return Image.asset(
          'assets/icon-read.png',
          color: InheritedChatTheme.of(context).theme.primaryColor,
          package: 'flutter_chat_ui',
        );
      case types.Status.sending:
        return SizedBox(
          height: 12,
          width: 12,
          child: CircularProgressIndicator(
            backgroundColor: Colors.transparent,
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              InheritedChatTheme.of(context).theme.primaryColor,
            ),
          ),
        );
      case types.Status.sent:
        return Image.asset(
          'assets/icon-sent.png',
          color: InheritedChatTheme.of(context).theme.primaryColor,
          package: 'flutter_chat_ui',
        );
      default:
        return Container();
    }
  }

  Widget _buildTime(bool currentUserIsAuthor, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(
            right: currentUserIsAuthor ? 8 : 16,
          ),
          child: Text(
            DateFormat.jm(dateLocale).format(
              DateTime.fromMillisecondsSinceEpoch(
                message.timestamp! * 1000,
              ),
            ),
            style: InheritedChatTheme.of(context).theme.caption.copyWith(
                  color: InheritedChatTheme.of(context).theme.captionColor,
                ),
          ),
        ),
        if (currentUserIsAuthor) _buildStatus(context)
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
                    ? InheritedChatTheme.of(context).theme.secondaryColor
                    : InheritedChatTheme.of(context).theme.primaryColor,
              ),
              child: ClipRRect(
                borderRadius: _borderRadius,
                child: _buildMessage(),
              ),
            ),
            if (shouldRenderTime)
              Container(
                margin: const EdgeInsets.only(
                  top: 8,
                ),
                child: _buildTime(_currentUserIsAuthor, context),
              )
          ],
        ),
      ),
    );
  }
}
