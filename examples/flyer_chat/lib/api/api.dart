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
import '../widgets/composer_action_bar.dart';
import 'api_service.dart';
import 'connection_status.dart';
import 'upload_file.dart';
import 'websocket_service.dart';

const baseUrl = 'https://whatever.diamanthq.dev';
const host = 'whatever.diamanthq.dev';

class Api extends StatefulWidget {
  final UserID currentUserId;
  final String chatId;
  final List<Message> initialMessages;
  final Dio dio;

  const Api({
    super.key,
    required this.currentUserId,
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

  final users = const {'john': User(id: 'john'), 'jane': User(id: 'jane')};

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
      authorId: widget.currentUserId,
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
      appBar: AppBar(title: const Text('Api')),
      body: Stack(
        children: [
          Chat(
            builders: Builders(
              textMessageBuilder:
                  (
                    context,
                    message,
                    index, {
                    required bool isSentByMe,
                    MessageGroupStatus? groupStatus,
                  }) => FlyerChatTextMessage(message: message, index: index),
              imageMessageBuilder:
                  (
                    context,
                    message,
                    index, {
                    required bool isSentByMe,
                    MessageGroupStatus? groupStatus,
                  }) => FlyerChatImageMessage(message: message, index: index),
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
                      onPressed: () async {
                        try {
                          await _apiService.flush();
                          if (mounted) {
                            await _chatController.setMessages([]);
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
            currentUserId: widget.currentUserId,
            onAttachmentTap: _handleAttachmentTap,
            onMessageSend: _addItem,
            onMessageTap: _removeItem,
            resolveUser: (id) => Future.value(users[id]),
            theme: ChatTheme.fromThemeData(theme),
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
    _webSocketSubscription = _webSocketService.connect().listen((event) {
      if (!mounted) return;

      switch (event.type) {
        case WebSocketEventType.newMessage:
          _chatController.insertMessage(event.message!);
          break;
        case WebSocketEventType.deleteMessage:
          _chatController.removeMessage(event.message!);
          break;
        case WebSocketEventType.flush:
          _chatController.setMessages([]);
          break;
        case WebSocketEventType.error:
          _showInfo('Error: ${event.error}');
          break;
        case WebSocketEventType.unknown:
          break;
      }
    });
  }

  void _addItem(String? text) async {
    final message = await createMessage(
      widget.currentUserId,
      widget.dio,
      text: text,
    );
    final originalMetadata = message.metadata;

    if (mounted) {
      await _chatController.insertMessage(
        message.copyWith(metadata: {...?originalMetadata, 'sending': true}),
      );
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
          createdAt: null,
          sentAt: DateTime.fromMillisecondsSinceEpoch(
            response['ts'],
            isUtc: true,
          ),
          metadata: originalMetadata,
        );
        await _chatController.updateMessage(currentMessage, nextMessage);
      }
    } catch (error) {
      debugPrint('Error sending message: $error');
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
      authorId: widget.currentUserId,
      createdAt: DateTime.now().toUtc(),
      source: image.path,
    );

    // Insert message to UI before uploading
    await _chatController.insertMessage(imageMessage);

    try {
      final response = await uploadFile(image.path, bytes, id, _chatController);

      if (mounted) {
        final blobId = response['blob_id'];

        // Make sure to get the updated message
        // (width and height might have been set by the image message widget)
        final currentMessage =
            _chatController.messages.firstWhere(
                  (element) => element.id == id,
                  orElse: () => imageMessage,
                )
                as ImageMessage;
        final originalMetadata = currentMessage.metadata;
        final nextMessage = currentMessage.copyWith(
          source: 'https://whatever.diamanthq.dev/blob/$blobId',
        );
        // Saves the same image to persistent cache using the new url as key
        // Alternatively, you could use updateKey to update the same content with a different key
        await _crossCache.set(nextMessage.source, bytes);
        await _chatController.updateMessage(
          currentMessage,
          nextMessage.copyWith(
            metadata: {...?originalMetadata, 'sending': true},
          ),
        );

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
            createdAt: null,
            sentAt: DateTime.fromMillisecondsSinceEpoch(
              newMessageResponse['ts'],
              isUtc: true,
            ),
            metadata: originalMetadata,
          );
          await _chatController.updateMessage(currentMessage2, nextMessage2);
        }
      }
    } catch (error) {
      debugPrint('Error uploading/sending image message: $error');
    }
  }

  void _removeItem(
    BuildContext context,
    Message item, {
    required int index,
    required TapUpDetails details,
  }) async {
    await _chatController.removeMessage(item);

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
