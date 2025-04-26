import 'dart:async';
import 'dart:convert';

import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

enum WebSocketEventType { newMessage, deleteMessage, flush, error, unknown }

enum WebSocketStatus { disconnected, connecting, connected, reconnecting }

class WebSocketEvent {
  final WebSocketEventType type;
  final Message? message;
  final String? error;

  const WebSocketEvent({required this.type, this.message, this.error});
}

class ChatWebSocketService {
  final String host;
  final String chatId;
  final UserID authorId;
  late WebSocketChannel _channel;
  final _statusController = StreamController<WebSocketStatus>.broadcast();
  WebSocketStatus _status = WebSocketStatus.disconnected;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  static const _maxReconnectDelay = Duration(seconds: 30);
  static const _baseReconnectDelay = Duration(seconds: 1);

  ChatWebSocketService({
    required this.host,
    required this.chatId,
    required this.authorId,
  });

  Stream<WebSocketStatus> get status => _statusController.stream;

  WebSocketStatus get currentStatus => _status;

  void _updateStatus(WebSocketStatus newStatus) {
    _status = newStatus;
    _statusController.add(newStatus);
  }

  Duration _getNextReconnectDelay() {
    if (_reconnectAttempts > 5) return _maxReconnectDelay;
    return _baseReconnectDelay * (1 << _reconnectAttempts);
  }

  Stream<WebSocketEvent> connect() async* {
    while (true) {
      try {
        _updateStatus(
          _reconnectAttempts == 0
              ? WebSocketStatus.connecting
              : WebSocketStatus.reconnecting,
        );

        final uri = Uri(
          scheme: 'wss',
          host: host,
          path: 'ws',
          queryParameters: {'authorId': authorId, 'chatId': chatId},
        );

        _channel = WebSocketChannel.connect(uri);
        await _channel.ready;

        _updateStatus(WebSocketStatus.connected);
        _reconnectAttempts = 0;
        _reconnectTimer?.cancel();

        await for (final message in _channel.stream) {
          try {
            yield _parseWebSocketMessage(message);
          } on FormatException catch (e) {
            yield WebSocketEvent(
              type: WebSocketEventType.error,
              error: 'Failed to parse message: ${e.message}',
            );
          } catch (e) {
            yield WebSocketEvent(
              type: WebSocketEventType.error,
              error: 'Error processing message: $e',
            );
          }
        }
      } on WebSocketChannelException catch (e) {
        yield WebSocketEvent(
          type: WebSocketEventType.error,
          error: 'WebSocket error: ${e.message}',
        );
        await _scheduleReconnect();
      } catch (e) {
        yield WebSocketEvent(
          type: WebSocketEventType.error,
          error: 'Connection error: $e',
        );
        await _scheduleReconnect();
      }
    }
  }

  Future<void> _scheduleReconnect() async {
    _updateStatus(WebSocketStatus.disconnected);
    _reconnectTimer?.cancel();

    final delay = _getNextReconnectDelay();
    _reconnectAttempts++;

    _reconnectTimer = Timer(delay, () {
      // Timer callback intentionally empty - the while loop in connect()
      // will handle the reconnection
    });

    await Future.delayed(delay);
  }

  WebSocketEvent _parseWebSocketMessage(dynamic message) {
    final Map<String, dynamic> json;
    try {
      json = jsonDecode(message);
    } catch (e) {
      throw FormatException('Invalid JSON format: $e');
    }

    if (json['msg'] != null) {
      final Message parsedMessage;
      try {
        parsedMessage = Message.fromJson(json['msg']);
      } catch (e) {
        throw FormatException('Invalid message format: $e');
      }

      if (json['op'] == 'new') {
        return WebSocketEvent(
          type: WebSocketEventType.newMessage,
          message: parsedMessage,
        );
      } else if (json['op'] == 'del') {
        return WebSocketEvent(
          type: WebSocketEventType.deleteMessage,
          message: parsedMessage,
        );
      }
    } else if (json['op'] == 'flush') {
      return const WebSocketEvent(type: WebSocketEventType.flush);
    }

    return const WebSocketEvent(type: WebSocketEventType.unknown);
  }

  void dispose() {
    _channel.sink.close();
    _reconnectTimer?.cancel();
    _statusController.close();
  }
}
