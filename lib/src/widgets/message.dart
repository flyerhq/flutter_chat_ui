import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/src/util.dart';
import 'package:intl/intl.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
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
    this.dateLocale,
    required this.message,
    required this.messageWidth,
    this.onMessageLongPress,
    this.onMessageTap,
    this.onPreviewDataFetched,
    required this.roundBorder,
    required this.shouldRenderTime,
    required this.usePreviewData,
    required this.showAvatar,
    required this.showName,
  }) : super(key: key);

  /// Locale will be passed to the `Intl` package. Make sure you initialized
  /// date formatting in your app before passing any locale here, otherwise
  /// an error will be thrown.
  final String? dateLocale;

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

  /// Whether delivery time should be rendered. It is not rendered for
  /// received messages and when sent messages have small difference in
  /// delivery time.
  final bool shouldRenderTime;

  /// Whether user avatar should be rendered for incoming messages. It is rendered
  /// only for last message in group by default.
  final bool showAvatar;

  /// Whether user name should be rendered for incoming messages. It is rendered
  /// only for first text message in group by default.
  final bool showName;

  /// See [TextMessage.usePreviewData]
  final bool usePreviewData;

  Widget _buildAvatar() {
    final hasAvatar = message.author.avatarUrl != null;
    final nameCharacters = getUserName(message.author).characters;

    return showAvatar
        ? Container(
            margin: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              backgroundImage:
                  hasAvatar ? NetworkImage(message.author.avatarUrl!) : null,
              backgroundColor: const Color(0xff66e0da),
              radius: 16,
              child: !hasAvatar
                  ? Text(
                      nameCharacters.isEmpty
                          ? ''
                          : nameCharacters.first.toUpperCase(),
                      style: const TextStyle(color: Colors.white),
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
        return Container();
    }
  }

  Widget _buildStatus(BuildContext context) {
    switch (message.status) {
      case types.Status.delivered:
        return InheritedChatTheme.of(context).theme.deliveredIcon != null
            ? Image.asset(
                InheritedChatTheme.of(context).theme.deliveredIcon!,
                color: InheritedChatTheme.of(context).theme.primaryColor,
              )
            : Image.asset(
                'assets/icon-delivered.png',
                color: InheritedChatTheme.of(context).theme.primaryColor,
                package: 'flutter_chat_ui',
              );
      case types.Status.read:
        return InheritedChatTheme.of(context).theme.readIcon != null
            ? Image.asset(
                InheritedChatTheme.of(context).theme.readIcon!,
                color: InheritedChatTheme.of(context).theme.primaryColor,
              )
            : Image.asset(
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
        left: 24,
        right: 24,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!_currentUserIsAuthor) _buildAvatar(),
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
        ],
      ),
    );
  }
}
