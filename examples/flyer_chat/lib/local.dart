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
  final User author;
  final Dio dio;

  const Local({super.key, required this.author, required this.dio});

  @override
  LocalState createState() => LocalState();
}

class LocalState extends State<Local> {
  final _chatController = InMemoryChatController();
  final _uuid = const Uuid();

  @override
  void dispose() {
    super.dispose();
    _chatController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local'),
      ),
      body: Chat(
        builders: Builders(
          textMessageBuilder: (context, message) =>
              FlyerChatTextMessage(message: message),
          imageMessageBuilder: (context, message) =>
              FlyerChatImageMessage(message: message),
          inputBuilder: (context) => ChatInput(
            topWidget: InputActionBar(
              buttons: [
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
        ),
        chatController: _chatController,
        user: widget.author,
        onMessageSend: _addItem,
        onMessageTap: _removeItem,
        onAttachmentTap: _handleAttachmentTap,
      ),
    );
  }

  void _addItem(String? text) async {
    final randomUser = Random().nextInt(2) == 0
        ? const User(id: 'sender1')
        : const User(id: 'sender2');

    final message = await createMessage(randomUser, widget.dio, text: text);

    if (mounted) {
      await _chatController.insert(message);
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
        author: widget.author,
        createdAt: DateTime.now().toUtc(),
        source: image.path,
      );

      await _chatController.insert(imageMessage);
    }
  }
}
