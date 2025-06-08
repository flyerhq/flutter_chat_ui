```dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flyer_chat_file_message/flyer_chat_file_message.dart';

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
          fileMessageBuilder: (context, message, index, {
            required bool isSentByMe,
            MessageGroupStatus? groupStatus,
          }) =>
            FlyerChatFileMessage(message: message, index: index),
        ),
        chatController: _chatController,
        currentUserId: 'user1',
        onAttachmentTap: () {
          // Implement a file picker to allow users to select files. For a comprehensive example, refer to:
          // https://github.com/flyerhq/flutter_chat_ui/blob/main/examples/flyer_chat
          final fileMessage = FileMessage(
            // Better to use UUID or similar for the ID - IDs must be unique
            id: '${Random().nextInt(1000) + 1}',
            authorId: 'user1',
            createdAt: DateTime.now().toUtc(),
            source: filePath,
            name: fileName,
            size: fileSize,
          );
          _chatController.insertMessage(fileMessage);
        },
        onMessageSend: (text) {},
        resolveUser: (UserID id) async {
          return User(id: id, name: 'John Doe');
        },
      ),
    );
  }
}

```