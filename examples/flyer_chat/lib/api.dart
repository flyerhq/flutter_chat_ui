import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flyer_chat_image_message/flyer_chat_image_message.dart';
import 'package:flyer_chat_text_message/flyer_chat_text_message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'create_message.dart';

class Api extends StatefulWidget {
  final User author;
  final String chatId;
  final List<Message> initialMessages;
  final Dio dio;

  const Api({
    super.key,
    required this.author,
    required this.chatId,
    required this.initialMessages,
    required this.dio,
  });

  @override
  ApiState createState() => ApiState();
}

class ApiState extends State<Api> {
  late WebSocketChannel _channel;
  late StreamSubscription<dynamic> _channelStream;
  late ChatController _chatController;

  @override
  void initState() {
    super.initState();
    _chatController = InMemoryChatController(messages: widget.initialMessages);

    _connectToWs();
  }

  @override
  void dispose() {
    super.dispose();
    _channelStream.cancel();
    _channel.sink.close();
    _chatController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Chat(
        builders: Builders(
          textMessageBuilder: (context, message) =>
              FlyerChatTextMessage(message: message),
          imageMessageBuilder: (context, message) =>
              FlyerChatImageMessage(message: message),
        ),
        chatController: _chatController,
        user: widget.author,
        onMessageSend: _addItem,
        onMessageTap: _removeItem,
        theme: ChatTheme.fromThemeData(theme),
        darkTheme: ChatTheme.fromThemeData(theme),
      ),
      persistentFooterButtons: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Go back'),
        ),
        TextButton(
          onPressed: () {
            _addItem(null);
          },
          child: const Text('Send random'),
        ),
        TextButton(
          onPressed: () {
            widget.dio
                .post(
              'https://whatever.diamanthq.dev/chat/${widget.chatId}/message-flush',
            )
                .then((response) {
              if (response.statusCode == 200) {
                if (mounted) {
                  _chatController.set([]);
                  _showInfo('All messages cleared');
                }
              } else {
                _showInfo('Error: ${response.statusCode}');
              }
            }).catchError((error) {
              _showInfo('Error: ${error.toString()}');
            });
          },
          child: const Text('Clear all messages'),
        ),
      ],
    );
  }

  void _connectToWs() async {
    final uri = Uri(
      scheme: 'wss',
      host: 'whatever.diamanthq.dev',
      path: 'ws',
      queryParameters: {'authorId': widget.author.id, 'chatId': widget.chatId},
    );

    _channel = WebSocketChannel.connect(uri);

    try {
      await _channel.ready;
    } on SocketException catch (e) {
      debugPrint(e.toString());
    } on WebSocketChannelException catch (e) {
      debugPrint(e.toString());
    }

    _channelStream = _channel.stream.listen((message) {
      try {
        final json = jsonDecode(message);
        if (json['msg'] != null) {
          final message = Message.fromJson(json['msg']);
          if (mounted) {
            if (json['op'] == 'new') {
              _chatController.insert(message);
            } else if (json['op'] == 'del') {
              _chatController.remove(message);
            }
          }
        }
      } catch (error) {
        _showInfo('Error: ${error.toString()}');
      }
    });
  }

  void _addItem(String? text) async {
    final message = await createMessage(widget.author, widget.dio, text: text);

    if (mounted) {
      await _chatController.insert(message);
    }

    try {
      final response = await widget.dio.post<Map<String, dynamic>>(
        'https://whatever.diamanthq.dev/chat/${widget.chatId}/message',
        data: message.toJson(),
      );

      if (mounted) {
        // Make sure to get the updated message
        // (width and height might have been set by the image message widget)
        final possiblyUpdatedMessage = _chatController.messages.firstWhere(
          (element) => element.id == message.id,
          orElse: () => message,
        );
        await _chatController.update(
          possiblyUpdatedMessage,
          possiblyUpdatedMessage.copyWith(id: response.data!['id']),
        );
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void _removeItem(Message item) async {
    await _chatController.remove(item);

    try {
      await widget.dio.delete<void>(
        'https://whatever.diamanthq.dev/chat/${widget.chatId}/message',
        data: {'id': item.id},
      );
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> _showInfo(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Info'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
