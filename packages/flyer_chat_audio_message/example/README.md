```dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flyer_chat_audio_message/flyer_chat_audio_message.dart';

/// Make your [ChatController] to with [AudioMessageBinding]
class LocalChatController extends InMemoryChatController with AudioMessageBinding {

}

class Basic extends StatefulWidget {
  const Basic({super.key});

  @override
  BasicState createState() => BasicState();
}

class BasicState extends State<Basic> {
  
  final _chatController = LocalChatController();
  
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
          audioMessageBuilder: (
              context,
              message,
              index, {
            required bool isSentByMe,
            MessageGroupStatus? groupStatus,
          }) => FlyerChatAudioMessage(message: message, waveColor: isSentByMe ? Colors.white : Colors.black,),
        ),
        chatController: _chatController,
        currentUserId: 'user1',
        onAttachmentTap: () {
          const source = 'https://cdn.pixabay.com/download/audio/2025/05/20/audio_baf0cfbdf7.mp3?filename=news-intro-344332.mp3';
          final audioMessage = AudioMessage(
            // Better to use UUID or similar for the ID - IDs must be unique
            id: '${Random().nextInt(1000) + 1}',
            authorId: 'user-2',
            createdAt: DateTime.now().toUtc(),
            source: source,
            size: 510,
            duration: Duration(seconds: 8),
          );
          _chatController.insertMessage(audioMessage);
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