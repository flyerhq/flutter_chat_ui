import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/src/widgets/inherited_user.dart';
import 'inherited_chat_theme.dart';

class RepliedMessage extends StatelessWidget {
  const RepliedMessage({
    Key? key,
    this.onCancelReplyPressed,
    this.messageAuthorId,
    required this.repliedMessage,
    this.showUserNames = false,
  }) : super(key: key);

  /// Called when user presses cancel reply button
  final void Function()? onCancelReplyPressed;

  /// Current message author id
  final String? messageAuthorId;

  /// Message that is being replied to by current message
  final types.Message? repliedMessage;

  /// Show user names for replied messages.
  final bool showUserNames;

  @override
  Widget build(BuildContext context) {
    String _text = '';
    String? _imageUri;
    final bool _closable = onCancelReplyPressed != null;
    final bool _isCurrentUser =
        messageAuthorId == InheritedUser.of(context).user.id;
    final _theme = InheritedChatTheme.of(context).theme;

    if (repliedMessage != null) {
      switch (repliedMessage!.type) {
        case types.MessageType.file:
          final fileMessage = repliedMessage as types.FileMessage;
          _text = fileMessage.name;
          break;
        case types.MessageType.image:
          final imageMessage = repliedMessage as types.ImageMessage;
          _text = "Photo";
          _imageUri = imageMessage.uri;
          break;
        case types.MessageType.text:
          final textMessage = repliedMessage as types.TextMessage;
          _text = textMessage.text;
          break;
        default:
          break;
      }
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: _closable ? 0 : 8),
      padding: _closable
          ? _theme.closableRepliedMessagePadding
          : _theme.repliedMessagePadding,
      decoration: _closable
          ? _theme.closableRepliedMessageBoxDecoration
          : _isCurrentUser
              ? _theme.repliedMessageSentBoxDecoration
              : _theme.repliedMessageReceivedBoxDecoration,
      child: Row(
        children: [
          _imageUri != null
              ? Container(
                  width: 44,
                  height: 44,
                  margin: _theme.repliedMessageImageMargin,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      _imageUri,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (repliedMessage?.author.firstName != null && showUserNames)
                  Text(
                    repliedMessage!.author.firstName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _isCurrentUser || _closable
                        ? _theme.sentMessageBodyTextStyle
                        : _theme.receivedMessageBodyTextStyle,
                  ),
                Text(
                  _text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _isCurrentUser || _closable
                      ? _theme.sentMessageBodyTextStyle
                      : _theme.receivedMessageBodyTextStyle,
                )
              ],
            ),
          ),
          if (_closable)
            Container(
              margin: _theme.closableRepliedMessageImageMargin,
              decoration: BoxDecoration(
                color: _theme.inputBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              height: 24,
              width: 24,
              child: IconButton(
                icon: Image.asset(
                  'assets/icon-x.png',
                  color: Colors.white,
                  package: 'flutter_chat_ui',
                ),
                onPressed: () => onCancelReplyPressed?.call(),
                padding: EdgeInsets.zero,
              ),
            ),
        ],
      ),
    );
  }
}
