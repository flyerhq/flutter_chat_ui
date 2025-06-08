```dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flyer_chat_system_message/flyer_chat_system_message.dart';

class Basic extends StatefulWidget {
  const Basic({super.key});

  @override
  BasicState createState() => BasicState();
}

class BasicState extends State<Basic> {
  final _chatController = InMemoryChatController();

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chat(
        builders: Builders(
          systemMessageBuilder: (context, message, index, {
            required bool isSentByMe,
            MessageGroupStatus? groupStatus,
          }) =>
            FlyerChatSystemMessage(message: message, index: index),
        ),
        chatController: _chatController,
        currentUserId: 'user1',
        onMessageSend: (text) {
          _chatController.insertMessage(
            SystemMessage(
              // Better to use UUID or similar for the ID - IDs must be unique
              id: '${Random().nextInt(1000) + 1}',
              authorId: 'system',
              createdAt: DateTime.now().toUtc(),
              text: text,
            ),
          );
        },
        resolveUser: (UserID id) async {
          return User(id: id, name: 'John Doe');
        },
      ),
    );
  }
}

```