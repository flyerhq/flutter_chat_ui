import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flyer_chat_image_message/flyer_chat_image_message.dart';
import 'package:flyer_chat_text_message/flyer_chat_text_message.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:uuid/uuid.dart';

import 'create_message.dart';
import 'widgets/input_action_bar.dart';

class Local extends StatefulWidget {
  final Dio dio;

  const Local({super.key, required this.dio});

  @override
  LocalState createState() => LocalState();
}

class LocalState extends State<Local> {
  final _chatController = InMemoryChatController();
  final _uuid = const Uuid();

  final _currentUser = const User(
    id: 'me',
    imageSource: 'https://picsum.photos/id/65/200/200',
  );
  final _recipient = const User(
    id: 'recipient',
    imageSource: 'https://picsum.photos/id/265/200/200',
  );
  final _systemUser = const User(id: 'system');

  bool _isTyping = false;

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
        backgroundColor: null,
        builders: Builders(
          customMessageBuilder:
              (context, message, index) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color:
                      theme.brightness == Brightness.dark
                          ? ChatColors.dark().surfaceContainer
                          : ChatColors.light().surfaceContainer,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: IsTypingIndicator(),
              ),
          imageMessageBuilder:
              (context, message, index) =>
                  FlyerChatImageMessage(message: message, index: index),
          inputBuilder:
              (context) => ChatInput(
                topWidget: InputActionBar(
                  buttons: [
                    InputActionButton(
                      icon: Icons.type_specimen,
                      title: 'Toggle typing',
                      onPressed: () => _toggleTyping(),
                    ),
                    InputActionButton(
                      icon: Icons.shuffle,
                      title: 'Send random',
                      onPressed: () => _addItem(null),
                    ),
                    InputActionButton(
                      icon: Icons.delete_sweep,
                      title: 'Clear all',
                      onPressed: () => _chatController.set([]),
                      destructive: true,
                    ),
                  ],
                ),
              ),
          textMessageBuilder:
              (context, message, index) =>
                  FlyerChatTextMessage(message: message, index: index),
          chatMessageBuilder: (
            context,
            message,
            index,
            animation,
            child, {
            bool? isRemoved,
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
              groupStatus: groupStatus,
              leadingWidget:
                  !isCurrentUser
                      ? avatar
                      : isSystemMessage
                      ? null
                      : const SizedBox(width: 40),
              trailingWidget:
                  isCurrentUser
                      ? avatar
                      : isSystemMessage
                      ? null
                      : const SizedBox(width: 40),
              child: child,
            );
          },
        ),
        chatController: _chatController,
        currentUserId: _currentUser.id,
        decoration: BoxDecoration(
          color:
              theme.brightness == Brightness.dark
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
        onAttachmentTap: _handleAttachmentTap,
        onMessageLongPress: _handleMessageLongPress,
        onMessageSend: _addItem,
        resolveUser:
            (id) => Future.value(switch (id) {
              'me' => _currentUser,
              'recipient' => _recipient,
              'system' => _systemUser,
              _ => null,
            }),
        theme:
            theme.brightness == Brightness.dark
                ? ChatTheme.dark()
                : ChatTheme.light(),
      ),
    );
  }

  void _handleMessageLongPress(
    Message message, {
    int? index,
    LongPressStartDetails? details,
  }) async {
    // Skip showing menu for system messages
    if (message.authorId == 'system' || details == null) return;

    // Calculate position for the menu
    final position = details.globalPosition;

    // Create a Rect for the menu position (small area around tap point)
    final menuRect = Rect.fromCenter(
      center: position,
      width: 0, // Width and height of 0 means show exactly at the point
      height: 0,
    );

    final items = [
      if (message is TextMessage)
        PullDownMenuItem(
          title: 'Copy',
          icon: CupertinoIcons.doc_on_doc,
          onTap: () {
            _copyMessage(message);
          },
        ),
      PullDownMenuItem(
        title: 'Delete',
        icon: CupertinoIcons.delete,
        isDestructive: true,
        onTap: () {
          _removeItem(message);
        },
      ),
    ];

    await showPullDownMenu(context: context, position: menuRect, items: items);
  }

  void _copyMessage(TextMessage message) async {
    await Clipboard.setData(ClipboardData(text: message.text));
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Copied: ${message.text}')));
  }

  void _addItem(String? text) async {
    final randomUser = Random().nextInt(2) == 0 ? _currentUser : _recipient;

    final message = await createMessage(randomUser.id, widget.dio, text: text);

    if (mounted) {
      if (_isTyping) {
        await _toggleTyping();
        await Future.delayed(const Duration(milliseconds: 250));
      }
      await _chatController.insert(message);
    }
  }

  Future<void> _toggleTyping() async {
    if (!_isTyping) {
      await _chatController.insert(
        CustomMessage(
          id: _uuid.v4(),
          authorId: _systemUser.id,
          createdAt: DateTime.now().toUtc(),
          metadata: {'type': 'typing'},
        ),
      );
      _isTyping = true;
    } else {
      try {
        final typingMessage = _chatController.messages.firstWhere(
          (message) => message.metadata?['type'] == 'typing',
        );

        await _chatController.remove(typingMessage);
        _isTyping = false;
      } catch (e) {
        _isTyping = false;
        await _toggleTyping();
      }
    }
  }

  void _removeItem(Message item) async {
    await _chatController.remove(item);
  }

  void _handleAttachmentTap() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final imageMessage = ImageMessage(
        id: _uuid.v4(),
        authorId: _currentUser.id,
        createdAt: DateTime.now().toUtc(),
        source: image.path,
      );

      await _chatController.insert(imageMessage);
    }
  }
}
