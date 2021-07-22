import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../util.dart';
import 'file_message.dart';
import 'image_message.dart';
import 'inherited_chat_theme.dart';
import 'inherited_user.dart';
import 'text_message.dart';

/// Base widget for all message types in the chat. Renders bubbles around
/// messages, delivery time and status. Sets maximum width for a message for
/// a nice look on larger screens.
class Message extends StatelessWidget {
  /// Creates a particular message from any message type
  const Message({
    Key? key,
    this.buildCustomMessage,
    required this.message,
    required this.messageWidth,
    this.onMessageLongPress,
    this.onMessageTap,
    this.onPreviewDataFetched,
    required this.roundBorder,
    required this.showAvatar,
    required this.showName,
    required this.showStatus,
    required this.showUserAvatars,
    required this.usePreviewData,
  }) : super(key: key);

  /// Build a custom message inside predefined bubble
  final Widget Function(types.Message)? buildCustomMessage;

  /// Any message type
  final types.Message message;

  /// Maximum message width
  final int messageWidth;

  /// Called when user makes a long press on any message
  final void Function(types.Message)? onMessageLongPress;

  /// Called when user taps on any message
  final void Function(types.Message)? onMessageTap;

  /// See [TextMessage.onPreviewDataFetched]
  final void Function(types.TextMessage, types.PreviewData)?
      onPreviewDataFetched;

  /// Rounds border of the message to visually group messages together.
  final bool roundBorder;

  /// Show user avatar for the received message. Useful for a group chat.
  final bool showAvatar;

  /// See [TextMessage.showName]
  final bool showName;

  /// Show message's status
  final bool showStatus;

  /// Show user avatars for received messages. Useful for a group chat.
  final bool showUserAvatars;

  /// See [TextMessage.usePreviewData]
  final bool usePreviewData;

  Widget _buildAvatar(BuildContext context) {
    final color = getUserAvatarNameColor(message.author,
        InheritedChatTheme.of(context).theme.userAvatarNameColors);
    final hasImage = message.author.imageUrl != null;
    final name = getUserName(message.author);

    return showAvatar
        ? Container(
            margin: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              backgroundImage:
                  hasImage ? NetworkImage(message.author.imageUrl!) : null,
              backgroundColor: color,
              radius: 16,
              child: !hasImage
                  ? Text(
                      name.isEmpty ? '' : name[0].toUpperCase(),
                      style: InheritedChatTheme.of(context)
                          .theme
                          .userAvatarTextStyle,
                    )
                  : null,
            ),
          )
        : Container(
            margin: const EdgeInsets.only(right: 40),
          );
  }

  Widget _buildMessage() {
    switch (message.type) {
      case types.MessageType.custom:
        final customMessage = message as types.CustomMessage;
        return buildCustomMessage != null
            ? buildCustomMessage!(customMessage)
            : const SizedBox();
      case types.MessageType.file:
        final fileMessage = message as types.FileMessage;
        return FileMessage(
          message: fileMessage,
        );
      case types.MessageType.image:
        final imageMessage = message as types.ImageMessage;
        return ImageMessage(
          message: imageMessage,
          messageWidth: messageWidth,
        );
      case types.MessageType.text:
        final textMessage = message as types.TextMessage;
        return TextMessage(
          message: textMessage,
          onPreviewDataFetched: onPreviewDataFetched,
          showName: showName,
          usePreviewData: usePreviewData,
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildStatus(BuildContext context) {
    switch (message.status) {
      case types.Status.error:
        return InheritedChatTheme.of(context).theme.errorIcon != null
            ? InheritedChatTheme.of(context).theme.errorIcon!
            : Image.asset(
                'assets/icon-error.png',
                color: InheritedChatTheme.of(context).theme.errorColor,
                package: 'flutter_chat_ui',
              );
      case types.Status.sent:
      case types.Status.delivered:
        return InheritedChatTheme.of(context).theme.deliveredIcon != null
            ? InheritedChatTheme.of(context).theme.deliveredIcon!
            : Image.asset(
                'assets/icon-delivered.png',
                color: InheritedChatTheme.of(context).theme.primaryColor,
                package: 'flutter_chat_ui',
              );
      case types.Status.seen:
        return InheritedChatTheme.of(context).theme.seenIcon != null
            ? InheritedChatTheme.of(context).theme.seenIcon!
            : Image.asset(
                'assets/icon-seen.png',
                color: InheritedChatTheme.of(context).theme.primaryColor,
                package: 'flutter_chat_ui',
              );
      case types.Status.sending:
        return InheritedChatTheme.of(context).theme.sendingIcon != null
            ? InheritedChatTheme.of(context).theme.sendingIcon!
            : Center(
                child: SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    strokeWidth: 1.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      InheritedChatTheme.of(context).theme.primaryColor,
                    ),
                  ),
                ),
              );
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _user = InheritedUser.of(context).user;
    final _messageBorderRadius =
        InheritedChatTheme.of(context).theme.messageBorderRadius;
    final _borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(_user.id == message.author.id || roundBorder
          ? _messageBorderRadius
          : 0),
      bottomRight: Radius.circular(_user.id == message.author.id
          ? roundBorder
              ? _messageBorderRadius
              : 0
          : _messageBorderRadius),
      topLeft: Radius.circular(_messageBorderRadius),
      topRight: Radius.circular(_messageBorderRadius),
    );
    final _currentUserIsAuthor = _user.id == message.author.id;

    return Container(
      alignment: _user.id == message.author.id
          ? Alignment.centerRight
          : Alignment.centerLeft,
      margin: const EdgeInsets.only(
        bottom: 4,
        left: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!_currentUserIsAuthor && showUserAvatars) _buildAvatar(context),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: messageWidth.toDouble(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onLongPress: () => onMessageLongPress?.call(message),
                  onTap: () => onMessageTap?.call(message),
                  child: Container(
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
                ),
              ],
            ),
          ),
          if (_currentUserIsAuthor)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Center(
                child: SizedBox(
                  height: 16,
                  width: 16,
                  child: showStatus ? _buildStatus(context) : null,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
