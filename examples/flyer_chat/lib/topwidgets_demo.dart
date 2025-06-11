import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flyer_chat_file_message/flyer_chat_file_message.dart';
import 'package:flyer_chat_image_message/flyer_chat_image_message.dart';
import 'package:flyer_chat_system_message/flyer_chat_system_message.dart';
import 'package:flyer_chat_text_message/flyer_chat_text_message.dart';
import 'package:uuid/uuid.dart';

import 'create_message.dart';
import 'widgets/composer_action_bar.dart';

class TopWidgetInBubble extends StatefulWidget {
  final Dio dio;

  const TopWidgetInBubble({super.key, required this.dio});

  @override
  TopWidgetInBubbleState createState() => TopWidgetInBubbleState();
}

class TopWidgetInBubbleState extends State<TopWidgetInBubble> {
  final _chatController = InMemoryChatController();
  final _uuid = const Uuid();

  final _currentUser = const User(
    id: 'me',
    imageSource: 'https://picsum.photos/id/65/200/200',
    name: 'Jane Doe',
  );
  final _recipient = const User(
    id: 'recipient',
    imageSource: 'https://picsum.photos/id/265/200/200',
    name: 'John Doe',
  );
  final _systemUser = const User(id: 'system');

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Local')),
      body: Chat(
        backgroundColor: Colors.transparent,
        builders: Builders(
          chatAnimatedListBuilder: (context, itemBuilder) {
            return ChatAnimatedList(
              itemBuilder: itemBuilder,
              insertAnimationDurationResolver: (message) {
                if (message is SystemMessage) return Duration.zero;
                return null;
              },
            );
          },
          customMessageBuilder:
              (
                context,
                message,
                index, {
                required bool isSentByMe,
                MessageGroupStatus? groupStatus,
              }) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.dark
                      ? ChatColors.dark().surfaceContainer
                      : ChatColors.light().surfaceContainer,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: IsTypingIndicator(),
              ),
          imageMessageBuilder:
              (
                context,
                message,
                index, {
                required bool isSentByMe,
                MessageGroupStatus? groupStatus,
              }) => FlyerChatImageMessage(
                message: message,
                index: index,
                topWidgets: [_buildUsername(message, isSentByMe, groupStatus)],
              ),
          systemMessageBuilder:
              (
                context,
                message,
                index, {
                required bool isSentByMe,
                MessageGroupStatus? groupStatus,
              }) => FlyerChatSystemMessage(message: message, index: index),
          composerBuilder: (context) => Composer(
            topWidget: ComposerActionBar(
              buttons: [
                ComposerActionButton(
                  icon: Icons.shuffle,
                  title: 'Send random',
                  onPressed: () => _addItem(null),
                ),
                ComposerActionButton(
                  icon: Icons.delete_sweep,
                  title: 'Clear all',
                  onPressed: () => _chatController.setMessages([]),
                  destructive: true,
                ),
              ],
            ),
          ),
          textMessageBuilder:
              (
                context,
                message,
                index, {
                required bool isSentByMe,
                MessageGroupStatus? groupStatus,
              }) => FlyerChatTextMessage(
                message: message,
                index: index,
                topWidgets: [_buildUsername(message, isSentByMe, groupStatus)],
              ),
          fileMessageBuilder:
              (
                context,
                message,
                index, {
                required bool isSentByMe,
                MessageGroupStatus? groupStatus,
              }) => FlyerChatFileMessage(message: message, index: index),
          chatMessageBuilder:
              (
                context,
                message,
                index,
                animation,
                child, {
                bool? isRemoved,
                required bool isSentByMe,
                MessageGroupStatus? groupStatus,
              }) {
                final isSystemMessage = message.authorId == 'system';
                final isLastInGroup = groupStatus?.isLast ?? true;
                final shouldShowAvatar =
                    !isSystemMessage && isLastInGroup && isRemoved != true;
                final isCurrentUser = message.authorId == _currentUser.id;

                Widget? avatar;
                if (shouldShowAvatar) {
                  avatar = Padding(
                    padding: EdgeInsets.only(
                      left: isCurrentUser ? 8 : 0,
                      right: isCurrentUser ? 0 : 8,
                    ),
                    child: Avatar(userId: message.authorId),
                  );
                } else if (!isSystemMessage) {
                  avatar = const SizedBox(width: 40);
                }

                return ChatMessage(
                  message: message,
                  index: index,
                  animation: animation,
                  isRemoved: isRemoved,
                  groupStatus: groupStatus,
                  leadingWidget: !isCurrentUser
                      ? avatar
                      : isSystemMessage
                      ? null
                      : const SizedBox(width: 40),
                  trailingWidget: isCurrentUser
                      ? avatar
                      : isSystemMessage
                      ? null
                      : const SizedBox(width: 40),
                  receivedMessageScaleAnimationAlignment:
                      (message is SystemMessage)
                      ? Alignment.center
                      : Alignment.centerLeft,
                  receivedMessageAlignment: (message is SystemMessage)
                      ? AlignmentDirectional.center
                      : AlignmentDirectional.centerStart,
                  horizontalPadding: (message is SystemMessage) ? 0 : 8,
                  child: child,
                );
              },
        ),
        chatController: _chatController,
        currentUserId: _currentUser.id,
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark
              ? ChatColors.dark().surface
              : ChatColors.light().surface,
          image: DecorationImage(
            image: AssetImage('assets/pattern.png'),
            repeat: ImageRepeat.repeat,
            colorFilter: ColorFilter.mode(
              theme.brightness == Brightness.dark
                  ? ChatColors.dark().surfaceContainerLow
                  : ChatColors.light().surfaceContainerLow,
              BlendMode.srcIn,
            ),
          ),
        ),
        onMessageSend: _addItem,
        resolveUser: (id) => Future.value(switch (id) {
          'me' => _currentUser,
          'recipient' => _recipient,
          'system' => _systemUser,
          _ => null,
        }),
        theme: theme.brightness == Brightness.dark
            ? ChatTheme.dark()
            : ChatTheme.light(),
      ),
    );
  }

  void _addItem(String? text) async {
    final randomUser = Random().nextInt(2) == 0 ? _currentUser : _recipient;

    final message = await createMessage(
      randomUser.id,
      widget.dio,
      localOnly: true,
      text: text,
    );

    if (mounted) {
      if (_chatController.messages.isEmpty) {
        final now = DateTime.now().toUtc();
        final formattedDate = DateFormat(
          'd MMMM yyyy, HH:mm',
        ).format(now.toLocal());
        await _chatController.insertMessage(
          SystemMessage(
            id: _uuid.v4(),
            authorId: _systemUser.id,
            text: formattedDate,
            createdAt: DateTime.now().toUtc().subtract(
              const Duration(seconds: 1),
            ),
          ),
        );
      }
      await _chatController.insertMessage(message);
    }
  }

  bool _shouldDisplayUsername(
    bool isSentByMe,
    MessageGroupStatus? groupStatus,
  ) {
    if (isSentByMe) {
      return false;
    }
    if (groupStatus?.isFirst ?? true) {
      return true;
    }
    return false;
  }

  Widget _buildUsername(
    Message message,
    bool isSentByMe,
    MessageGroupStatus? groupStatus,
  ) {
    if (!_shouldDisplayUsername(isSentByMe, groupStatus)) {
      return const SizedBox.shrink();
    }
    // Resove somehow a user color, it's your own loading
    final color = message.authorId == _currentUser.id
        ? Colors.blue.shade400
        : Colors.red.shade400;
    // Get the theme from your code or wathever fits
    final textStyle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: color, fontWeight: FontWeight.bold);
    // Adapt padding
    EdgeInsets? padding;
    if (message is ImageMessage) {
      // Mimic FlyerChatText Default Padding
      padding = EdgeInsets.only(top: 5, left: 8, right: 8);
    }
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Username(userId: message.authorId, style: textStyle),
    );
  }
}
