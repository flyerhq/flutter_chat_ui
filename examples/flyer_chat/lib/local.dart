import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flyer_chat_image_message/flyer_chat_image_message.dart';
import 'package:flyer_chat_text_message/flyer_chat_text_message.dart';
import 'package:image_picker/image_picker.dart';
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

  final _currentUser = const User(id: 'me');
  final _recipient = const User(id: 'recipient');
  final _systemUser = const User(id: 'system');

  bool _isTyping = false;

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local'),
      ),
      body: Chat(
        builders: Builders(
          customMessageBuilder: (context, message, index) => Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFF0F0F0),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: IsTypingIndicator(),
          ),
          imageMessageBuilder: (context, message, index) =>
              FlyerChatImageMessage(message: message, index: index),
          inputBuilder: (context) => ChatInput(
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
          textMessageBuilder: (context, message, index) =>
              FlyerChatTextMessage(message: message, index: index),
        ),
        chatController: _chatController,
        currentUserId: _currentUser.id,
        darkTheme: ChatTheme.dark(
          isTypingTheme: IsTypingTheme.dark(
            color: Color(0xFF101010),
          ),
        ),
        onAttachmentTap: _handleAttachmentTap,
        onMessageSend: _addItem,
        onMessageTap: _removeItem,
        resolveUser: (id) => Future.value(
          switch (id) {
            'me' => _currentUser,
            'recipient' => _recipient,
            'system' => _systemUser,
            _ => null,
          },
        ),
      ),
    );
  }

  void _addItem(String? text) async {
    final randomUser = Random().nextInt(2) == 0 ? _currentUser : _recipient;

    final message = await createMessage(
      randomUser.id,
      widget.dio,
      text: text,
    );

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
          metadata: {
            'type': 'typing',
          },
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
