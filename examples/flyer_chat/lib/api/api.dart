import 'dart:async';

import 'package:cross_cache/cross_cache.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flyer_chat_image_message/flyer_chat_image_message.dart';
import 'package:flyer_chat_text_message/flyer_chat_text_message.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../create_message.dart';
import '../widgets/input_action_bar.dart';
import 'api_service.dart';
import 'connection_status.dart';
import 'upload_file.dart';
import 'websocket_service.dart';

const baseUrl = 'https://whatever.diamanthq.dev';
const host = 'whatever.diamanthq.dev';

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
  final _crossCache = CrossCache();
  final _uuid = const Uuid();

  late final ApiService _apiService;
  late final ChatWebSocketService _webSocketService;
  late final StreamSubscription<WebSocketEvent> _webSocketSubscription;
  late final ChatController _chatController;

  @override
  void initState() {
    super.initState();
    _chatController = InMemoryChatController(messages: widget.initialMessages);
    _apiService = ApiService(
      baseUrl: baseUrl,
      chatId: widget.chatId,
      dio: widget.dio,
    );
    _webSocketService = ChatWebSocketService(
      host: host,
      chatId: widget.chatId,
      authorId: widget.author.id,
    );

    _connectToWs();
  }

  @override
  void dispose() {
    _webSocketSubscription.cancel();
    _webSocketService.dispose();
    _chatController.dispose();
    _crossCache.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Api'),
      ),
      body: Stack(
        children: [
          Chat(
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
                      onPressed: () async {
                        try {
                          await _apiService.flush();
                          if (mounted) {
                            await _chatController.set([]);
                            await _showInfo('All messages cleared');
                          }
                        } catch (error) {
                          await _showInfo('Error: $error');
                        }
                      },
                      destructive: true,
                    ),
                  ],
                ),
              ),
            ),
            chatController: _chatController,
            crossCache: _crossCache,
            user: widget.author,
            onMessageSend: _addItem,
            onMessageTap: _removeItem,
            onAttachmentTap: _handleAttachmentTap,
            theme: ChatTheme.fromThemeData(theme),
            darkTheme: ChatTheme.fromThemeData(theme),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: ConnectionStatus(webSocketService: _webSocketService),
          ),
        ],
      ),
    );
  }

  void _connectToWs() {
    _webSocketSubscription = _webSocketService.connect().listen(
      (event) {
        if (!mounted) return;

        switch (event.type) {
          case WebSocketEventType.newMessage:
            _chatController.insert(event.message!);
            break;
          case WebSocketEventType.deleteMessage:
            _chatController.remove(event.message!);
            break;
          case WebSocketEventType.flush:
            _chatController.set([]);
            break;
          case WebSocketEventType.error:
            _showInfo('Error: ${event.error}');
            break;
          case WebSocketEventType.unknown:
            break;
        }
      },
    );
  }

  void _addItem(String? text) async {
    final message = await createMessage(widget.author, widget.dio, text: text);

    if (mounted) {
      await _chatController.insert(message);
    }

    try {
      final response = await _apiService.send(message);

      if (mounted) {
        // Make sure to get the updated message
        // (width and height might have been set by the image message widget)
        final currentMessage = _chatController.messages.firstWhere(
          (element) => element.id == message.id,
          orElse: () => message,
        );
        final nextMessage = currentMessage.copyWith(
          id: response['id'],
          createdAt: DateTime.fromMicrosecondsSinceEpoch(
            response['createdAt'],
            isUtc: true,
          ),
        );
        await _chatController.update(currentMessage, nextMessage);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void _handleAttachmentTap() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    final bytes = await image.readAsBytes();
    // Saves image to persistent cache using image.path as key
    await _crossCache.set(image.path, bytes);

    final id = _uuid.v4();

    final imageMessage = ImageMessage(
      id: id,
      author: widget.author,
      createdAt: DateTime.now().toUtc(),
      source: image.path,
    );

    // Insert message to UI before uploading
    await _chatController.insert(imageMessage);

    try {
      final response = await uploadFile(image.path, bytes, id, _chatController);

      if (mounted) {
        final blobId = response['blob_id'];

        // Make sure to get the updated message
        // (width and height might have been set by the image message widget)
        final currentMessage = _chatController.messages.firstWhere(
          (element) => element.id == id,
          orElse: () => imageMessage,
        ) as ImageMessage;
        final nextMessage = currentMessage.copyWith(
          source: 'https://whatever.diamanthq.dev/blob/$blobId',
        );
        // Saves the same image to persistent cache using the new url as key
        // Alternatively, you could use updateKey to update the same content with a different key
        await _crossCache.set(nextMessage.source, bytes);
        await _chatController.update(currentMessage, nextMessage);

        final newMessageResponse = await _apiService.send(nextMessage);

        if (mounted) {
          // Make sure to get the updated message
          // (width and height might have been set by the image message widget)
          final currentMessage2 = _chatController.messages.firstWhere(
            (element) => element.id == nextMessage.id,
            orElse: () => nextMessage,
          );
          final nextMessage2 = currentMessage2.copyWith(
            id: newMessageResponse['id'],
            createdAt: DateTime.fromMicrosecondsSinceEpoch(
              newMessageResponse['createdAt'],
              isUtc: true,
            ),
          );
          await _chatController.update(currentMessage2, nextMessage2);
        }
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void _removeItem(Message item) async {
    await _chatController.remove(item);

    try {
      await _apiService.delete(item);
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
