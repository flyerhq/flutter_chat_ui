import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:swipe_to/swipe_to.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../flutter_chat_ui.dart';
import '../../conditional/conditional.dart';
import '../../util.dart';
import '../state/inherited_chat_theme.dart';
import '../state/inherited_user.dart';

/// Base widget for all message types in the chat. Renders bubbles around
/// messages and status. Sets maximum width for a message for
/// a nice look on larger screens.
class Message extends StatelessWidget {
  /// Creates a particular message from any message type.
  const Message({
    super.key,
    this.audioMessageBuilder,
    this.avatarBuilder,
    this.bubbleBuilder,
    this.bubbleRtlAlignment,
    this.customMessageBuilder,
    this.customStatusBuilder,
    required this.emojiEnlargementBehavior,
    this.fileMessageBuilder,
    required this.hideBackgroundOnEmojiMessages,
    this.imageHeaders,
    this.imageMessageBuilder,
    this.imageProviderBuilder,
    required this.message,
    required this.messageWidth,
    this.nameBuilder,
    this.onAvatarTap,
    this.onMessageDoubleTap,
    this.onMessageLongPress,
    this.onMessageStatusLongPress,
    this.onSwipeToRight,
    this.onSwipeToLeft,
    this.onMessageStatusTap,
    this.onMessageTap,
    this.onMessageVisibilityChanged,
    this.onPreviewDataFetched,
    required this.roundBorder,
    required this.showAvatar,
    required this.showName,
    required this.showStatus,
    required this.showUserAvatars,
    this.textMessageBuilder,
    required this.textMessageOptions,
    required this.usePreviewData,
    this.userAgent,
    this.videoMessageBuilder,
  });

  /// Build an audio message inside predefined bubble.
  final Widget Function(types.AudioMessage, {required int messageWidth})?
      audioMessageBuilder;

  /// This is to allow custom user avatar builder
  /// By using this we can fetch newest user info based on id.
  final Widget Function(String userId)? avatarBuilder;

  /// Customize the default bubble using this function. `child` is a content
  /// you should render inside your bubble, `message` is a current message
  /// (contains `author` inside) and `nextMessageInGroup` allows you to see
  /// if the message is a part of a group (messages are grouped when written
  /// in quick succession by the same author).
  final Widget Function(
    Widget child, {
    required types.Message message,
    required bool nextMessageInGroup,
  })? bubbleBuilder;

  /// Determine the alignment of the bubble for RTL languages. Has no effect
  /// for the LTR languages.
  final BubbleRtlAlignment? bubbleRtlAlignment;

  /// Build a custom message inside predefined bubble.
  final Widget Function(types.CustomMessage, {required int messageWidth})?
      customMessageBuilder;

  /// Build a custom status widgets.
  final Widget Function(types.Message message, {required BuildContext context})?
      customStatusBuilder;

  /// Controls the enlargement behavior of the emojis in the
  /// [types.TextMessage].
  /// Defaults to [EmojiEnlargementBehavior.multi].
  final EmojiEnlargementBehavior emojiEnlargementBehavior;

  /// Build a file message inside predefined bubble.
  final Widget Function(types.FileMessage, {required int messageWidth})?
      fileMessageBuilder;

  /// Hide background for messages containing only emojis.
  final bool hideBackgroundOnEmojiMessages;

  /// See [Chat.imageHeaders].
  final Map<String, String>? imageHeaders;

  /// Build an image message inside predefined bubble.
  final Widget Function(types.ImageMessage, {required int messageWidth})?
      imageMessageBuilder;

  /// See [Chat.imageProviderBuilder].
  final ImageProvider Function({
    required String uri,
    required Map<String, String>? imageHeaders,
    required Conditional conditional,
  })? imageProviderBuilder;

  /// Any message type.
  final types.Message message;

  /// Maximum message width.
  final int messageWidth;

  /// See [TextMessage.nameBuilder].
  final Widget Function(types.User)? nameBuilder;

  /// See [UserAvatar.onAvatarTap].
  final void Function(types.User)? onAvatarTap;

  /// Called when user double taps on any message.
  final void Function(BuildContext context, types.Message)? onMessageDoubleTap;

  /// Called when user makes a long press on any message.
  final void Function(BuildContext context, types.Message)? onMessageLongPress;
  final void Function(BuildContext context, types.Message)? onSwipeToRight;
  final void Function(BuildContext context, types.Message)? onSwipeToLeft;

  /// Called when user makes a long press on status icon in any message.
  final void Function(BuildContext context, types.Message)?
      onMessageStatusLongPress;

  /// Called when user taps on status icon in any message.
  final void Function(BuildContext context, types.Message)? onMessageStatusTap;

  /// Called when user taps on any message.
  final void Function(BuildContext context, types.Message)? onMessageTap;

  /// Called when the message's visibility changes.
  final void Function(types.Message, bool visible)? onMessageVisibilityChanged;

  /// See [TextMessage.onPreviewDataFetched].
  final void Function(types.TextMessage, types.PreviewData)?
      onPreviewDataFetched;

  /// Rounds border of the message to visually group messages together.
  final bool roundBorder;

  /// Show user avatar for the received message. Useful for a group chat.
  final bool showAvatar;

  /// See [TextMessage.showName].
  final bool showName;

  /// Show message's status.
  final bool showStatus;

  /// Show user avatars for received messages. Useful for a group chat.
  final bool showUserAvatars;

  /// Build a text message inside predefined bubble.
  final Widget Function(
    types.TextMessage, {
    required int messageWidth,
    required bool showName,
  })? textMessageBuilder;

  /// See [TextMessage.options].
  final TextMessageOptions textMessageOptions;

  /// See [TextMessage.usePreviewData].
  final bool usePreviewData;

  /// See [TextMessage.userAgent].
  final String? userAgent;

  /// Build an audio message inside predefined bubble.
  final Widget Function(types.VideoMessage, {required int messageWidth})?
      videoMessageBuilder;

  Widget _avatarBuilder() => showAvatar
      ? avatarBuilder?.call(message.author.id) ??
          UserAvatar(
            author: message.author,
            bubbleRtlAlignment: bubbleRtlAlignment,
            imageHeaders: imageHeaders,
            onAvatarTap: onAvatarTap,
          )
      : const SizedBox(width: 40);

  Widget _bubbleBuilder(
    BuildContext context,
    BorderRadius borderRadius,
    bool currentUserIsAuthor,
    bool enlargeEmojis,
  ) =>
      bubbleBuilder != null
          ? bubbleBuilder!(
              _messageBuilder(context),
              message: message,
              nextMessageInGroup: roundBorder,
            )
          : enlargeEmojis && hideBackgroundOnEmojiMessages
              ? _messageBuilder(context)
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    color: !currentUserIsAuthor ||
                            message.type == types.MessageType.image
                        ? InheritedChatTheme.of(context).theme.secondaryColor
                        : InheritedChatTheme.of(context).theme.primaryColor,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      color: InheritedChatTheme.of(context).theme.primaryColor,
                    ),
                    child: IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (message.repliedMessage != null)
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4.0, right: 4.0, left: 4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        color: InheritedChatTheme.of(context)
                                            .theme
                                            .secondaryColor,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: borderRadius,
                                        child: _repliedMessageBuilder(
                                            message.repliedMessage!),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          Row(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: borderRadius,
                                  child: _messageBuilder(context),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );

  Widget _messageBuilder(BuildContext context) {
    switch (message.type) {
      case types.MessageType.audio:
        final audioMessage = message as types.AudioMessage;
        return audioMessageBuilder != null
            ? audioMessageBuilder!(audioMessage, messageWidth: messageWidth)
            : const SizedBox();
      case types.MessageType.custom:
        final customMessage = message as types.CustomMessage;
        return customMessageBuilder != null
            ? customMessageBuilder!(customMessage, messageWidth: messageWidth)
            : const SizedBox();
      case types.MessageType.file:
        final fileMessage = message as types.FileMessage;
        return fileMessageBuilder != null
            ? fileMessageBuilder!(fileMessage, messageWidth: messageWidth)
            : FileMessage(message: fileMessage);
      case types.MessageType.image:
        final imageMessage = message as types.ImageMessage;
        return imageMessageBuilder != null
            ? imageMessageBuilder!(imageMessage, messageWidth: messageWidth)
            : Padding(
                padding: const EdgeInsets.all(4.0),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: ImageMessage(
                        imageHeaders: imageHeaders,
                        imageProviderBuilder: imageProviderBuilder,
                        message: imageMessage,
                        messageWidth: messageWidth,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 4, left: 4, bottom: 4.0, right: 8),
                        child: Row(
                          children: [
                            Text(
                              '19:49',
                              style: InheritedChatTheme.of(context)
                                  .theme
                                  .sentMessageBodyTextStyle
                                  .copyWith(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            if (message.author.id ==
                                InheritedUser.of(context).user.id)
                              Padding(
                                padding: EdgeInsets.zero,
                                child: showStatus
                                    ? GestureDetector(
                                        onLongPress: () =>
                                            onMessageStatusLongPress?.call(
                                                context, message),
                                        onTap: () => onMessageStatusTap?.call(
                                            context, message),
                                        child: customStatusBuilder != null
                                            ? customStatusBuilder!(message,
                                                context: context)
                                            : MessageStatus(
                                                status: message.status),
                                      )
                                    : null,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
      case types.MessageType.text:
        final textMessage = message as types.TextMessage;
        return textMessageBuilder != null
            ? textMessageBuilder!(
                textMessage,
                messageWidth: messageWidth,
                showName: showName,
              )
            : Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: TextMessage(
                      emojiEnlargementBehavior: emojiEnlargementBehavior,
                      hideBackgroundOnEmojiMessages:
                          hideBackgroundOnEmojiMessages,
                      message: textMessage,
                      nameBuilder: nameBuilder,
                      onPreviewDataFetched: onPreviewDataFetched,
                      options: textMessageOptions,
                      showName: showName,
                      usePreviewData: usePreviewData,
                      userAgent: userAgent,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0, right: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '19:49',
                            style: InheritedChatTheme.of(context)
                                .theme
                                .sentMessageBodyTextStyle
                                .copyWith(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          if (message.author.id ==
                              InheritedUser.of(context).user.id)
                            Padding(
                              padding: EdgeInsets.zero,
                              child: showStatus
                                  ? GestureDetector(
                                      onLongPress: () =>
                                          onMessageStatusLongPress?.call(
                                              context, message),
                                      onTap: () => onMessageStatusTap?.call(
                                          context, message),
                                      child: customStatusBuilder != null
                                          ? customStatusBuilder!(message,
                                              context: context)
                                          : MessageStatus(
                                              status: message.status),
                                    )
                                  : null,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
      case types.MessageType.video:
        final videoMessage = message as types.VideoMessage;
        return videoMessageBuilder != null
            ? videoMessageBuilder!(videoMessage, messageWidth: messageWidth)
            : const SizedBox();
      default:
        return const SizedBox();
    }
  }

  Widget _repliedMessageBuilder(types.Message repliedMessage) {
    switch (repliedMessage.type) {
      case types.MessageType.audio:
        final audioMessage = repliedMessage as types.AudioMessage;
        return audioMessageBuilder != null
            ? audioMessageBuilder!(audioMessage, messageWidth: messageWidth)
            : const SizedBox();
      case types.MessageType.custom:
        final customMessage = repliedMessage as types.CustomMessage;
        return customMessageBuilder != null
            ? customMessageBuilder!(customMessage, messageWidth: messageWidth)
            : const SizedBox();
      case types.MessageType.file:
        final fileMessage = repliedMessage as types.FileMessage;
        return fileMessageBuilder != null
            ? fileMessageBuilder!(fileMessage, messageWidth: messageWidth)
            : FileMessage(message: fileMessage);
      case types.MessageType.image:
        final imageMessage = repliedMessage as types.ImageMessage;
        return imageMessageBuilder != null
            ? imageMessageBuilder!(imageMessage, messageWidth: messageWidth)
            : Row(
                children: [
                  Expanded(
                    child: TextMessage(
                      emojiEnlargementBehavior: emojiEnlargementBehavior,
                      hideBackgroundOnEmojiMessages:
                          hideBackgroundOnEmojiMessages,
                      message: types.TextMessage(
                          author: repliedMessage.author,
                          createdAt: repliedMessage.createdAt,
                          id: repliedMessage.id,
                          text: 'Fotoğraf'),
                      nameBuilder: nameBuilder,
                      onPreviewDataFetched: onPreviewDataFetched,
                      showName: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      usePreviewData: usePreviewData,
                      userAgent: userAgent,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ImageMessage(
                    imageHeaders: imageHeaders,
                    imageProviderBuilder: imageProviderBuilder,
                    message: imageMessage,
                    messageWidth: 50,
                    minWidth: 50,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              );
      case types.MessageType.text:
        final textMessage = repliedMessage as types.TextMessage;
        return textMessageBuilder != null
            ? textMessageBuilder!(
                textMessage,
                messageWidth: messageWidth,
                showName: showName,
              )
            : TextMessage(
                emojiEnlargementBehavior: emojiEnlargementBehavior,
                hideBackgroundOnEmojiMessages: hideBackgroundOnEmojiMessages,
                message: textMessage,
                nameBuilder: nameBuilder,
                onPreviewDataFetched: onPreviewDataFetched,
                options: textMessageOptions,
                showName: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                usePreviewData: usePreviewData,
                userAgent: userAgent,
              );
      case types.MessageType.video:
        final videoMessage = repliedMessage as types.VideoMessage;
        return videoMessageBuilder != null
            ? videoMessageBuilder!(videoMessage, messageWidth: messageWidth)
            : const SizedBox();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final user = InheritedUser.of(context).user;
    final currentUserIsAuthor = user.id == message.author.id;
    final enlargeEmojis =
        emojiEnlargementBehavior != EmojiEnlargementBehavior.never &&
            message is types.TextMessage &&
            isConsistsOfEmojis(
              emojiEnlargementBehavior,
              message as types.TextMessage,
            );
    final messageBorderRadius =
        InheritedChatTheme.of(context).theme.messageBorderRadius;
    final borderRadius = bubbleRtlAlignment == BubbleRtlAlignment.left
        ? BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(
              !currentUserIsAuthor || roundBorder ? messageBorderRadius : 0,
            ),
            bottomStart: Radius.circular(
              currentUserIsAuthor || roundBorder ? messageBorderRadius : 0,
            ),
            topEnd: Radius.circular(messageBorderRadius),
            topStart: Radius.circular(messageBorderRadius),
          )
        : BorderRadius.only(
            bottomLeft: Radius.circular(
              currentUserIsAuthor || roundBorder ? messageBorderRadius : 0,
            ),
            bottomRight: Radius.circular(
              !currentUserIsAuthor || roundBorder ? messageBorderRadius : 0,
            ),
            topLeft: Radius.circular(messageBorderRadius),
            topRight: Radius.circular(messageBorderRadius),
          );

    return SwipeTo(
      onRightSwipe: (a) {
        onSwipeToRight?.call(context, message);
      },
      child: Container(
        alignment: bubbleRtlAlignment == BubbleRtlAlignment.left
            ? currentUserIsAuthor
                ? AlignmentDirectional.centerEnd
                : AlignmentDirectional.centerStart
            : currentUserIsAuthor
                ? Alignment.centerRight
                : Alignment.centerLeft,
        margin: bubbleRtlAlignment == BubbleRtlAlignment.left
            ? EdgeInsetsDirectional.only(
                bottom: 4,
                end: isMobile ? query.padding.right : 0,
                start: 20 + (isMobile ? query.padding.left : 0),
              )
            : EdgeInsets.only(
                bottom: 4,
                left: 20 + (isMobile ? query.padding.left : 0),
                right: isMobile ? query.padding.right : 0,
              ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          textDirection: bubbleRtlAlignment == BubbleRtlAlignment.left
              ? null
              : TextDirection.ltr,
          children: [
            if (!currentUserIsAuthor && showUserAvatars) _avatarBuilder(),
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 170,
                maxWidth: messageWidth.toDouble(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onDoubleTap: () =>
                        onMessageDoubleTap?.call(context, message),
                    onLongPress: () =>
                        onMessageLongPress?.call(context, message),
                    onTap: () => onMessageTap?.call(context, message),
                    child: onMessageVisibilityChanged != null
                        ? VisibilityDetector(
                            key: Key(message.id),
                            onVisibilityChanged: (visibilityInfo) =>
                                onMessageVisibilityChanged!(
                              message,
                              visibilityInfo.visibleFraction > 0.1,
                            ),
                            child: _bubbleBuilder(
                              context,
                              borderRadius.resolve(Directionality.of(context)),
                              currentUserIsAuthor,
                              enlargeEmojis,
                            ),
                          )
                        : _bubbleBuilder(
                            context,
                            borderRadius.resolve(Directionality.of(context)),
                            currentUserIsAuthor,
                            enlargeEmojis,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
