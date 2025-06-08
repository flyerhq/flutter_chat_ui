```dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flyer_chat_text_stream_message/flyer_chat_text_stream_message.dart';

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
            textStreamMessageBuilder: (context, message, index, {
              required bool isSentByMe,
              MessageGroupStatus? groupStatus,
            }) {
              // To see a practical implementation of the stream manager, check the main example app at
              // https://github.com/flyerhq/flutter_chat_ui/tree/main/examples/flyer_chat
              final streamState = context.watch<GeminiStreamManager>().getState(
                message.streamId,
              );
              // Return the stream message widget, passing the state
              return FlyerChatTextStreamMessage(
                message: message,
                index: index,
                streamState: streamState,
              );
            },
        ),
        chatController: _chatController,
        currentUserId: 'user1',
        onMessageSend: (text) {
          _chatController.insertMessage(
            // For a comprehensive example of how to implement the stream manager and work with streamIds, refer to the main example application available at
            // https://github.com/flyerhq/flutter_chat_ui/tree/main/examples/flyer_chat
            TextStreamMessage(
              id: streamId,
              authorId: 'agent1',
              createdAt: DateTime.now().toUtc(),
              streamId: streamId,
            )
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