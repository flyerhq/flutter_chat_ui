import 'dart:async';

import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:hive_ce/hive.dart';

class HiveChatController
    with UploadProgressMixin, ScrollToMessageMixin
    implements ChatController {
  final _box = Hive.box('chat');
  final _operationsController = StreamController<ChatOperation>.broadcast();

  // Cache for performance - invalidated when data changes
  List<Message>? _cachedMessages;

  @override
  Future<void> insertMessage(Message message, {int? index}) async {
    if (_box.containsKey(message.id)) return;

    // Index is ignored because Hive does not maintain order
    await _box.put(message.id, message.toJson());
    _invalidateCache();
    _operationsController.add(ChatOperation.insert(message, _box.length - 1));
  }

  @override
  Future<void> removeMessage(Message message) async {
    final sortedMessages = List.from(messages);
    final index = sortedMessages.indexWhere((m) => m.id == message.id);

    if (index != -1) {
      final messageToRemove = sortedMessages[index];
      await _box.delete(messageToRemove.id);
      _invalidateCache();
      _operationsController.add(ChatOperation.remove(messageToRemove, index));
    }
  }

  @override
  Future<void> updateMessage(Message oldMessage, Message newMessage) async {
    final sortedMessages = List.from(messages);
    final index = sortedMessages.indexWhere((m) => m.id == oldMessage.id);

    if (index != -1) {
      final actualOldMessage = sortedMessages[index];

      if (actualOldMessage == newMessage) {
        return;
      }

      await _box.put(actualOldMessage.id, newMessage.toJson());
      _invalidateCache();
      _operationsController.add(
        ChatOperation.update(actualOldMessage, newMessage, index),
      );
    }
  }

  @override
  Future<void> setMessages(List<Message> messages) async {
    await _box.clear();
    if (messages.isEmpty) {
      _invalidateCache();
      _operationsController.add(ChatOperation.set([]));
      return;
    } else {
      await _box.putAll(
        messages
            .map((message) => {message.id: message.toJson()})
            .toList()
            .reduce((acc, map) => {...acc, ...map}),
      );
      _invalidateCache();
      _operationsController.add(ChatOperation.set(messages));
    }
  }

  @override
  Future<void> insertAllMessages(List<Message> messages, {int? index}) async {
    if (messages.isEmpty) return;

    // Index is ignored because Hive does not maintain order
    final originalLength = _box.length;
    await _box.putAll(
      messages
          .map((message) => {message.id: message.toJson()})
          .toList()
          .reduce((acc, map) => {...acc, ...map}),
    );
    _invalidateCache();
    _operationsController.add(
      ChatOperation.insertAll(messages, originalLength),
    );
  }

  /// Invalidates the cached messages list
  void _invalidateCache() {
    _cachedMessages = null;
  }

  @override
  List<Message> get messages {
    if (_cachedMessages != null) {
      return _cachedMessages!;
    }

    _cachedMessages =
        _box.values.map((json) => Message.fromJson(_convertMap(json))).toList()
          ..sort(
            (a, b) => (a.createdAt?.millisecondsSinceEpoch ?? 0).compareTo(
              b.createdAt?.millisecondsSinceEpoch ?? 0,
            ),
          );

    return _cachedMessages!;
  }

  @override
  Stream<ChatOperation> get operationsStream => _operationsController.stream;

  @override
  void dispose() {
    _operationsController.close();
    disposeUploadProgress();
    disposeScrollMethods();
  }
}

/// Recursively converts a map with dynamic keys and values to a map with String keys.
/// It's optimized to avoid creating new maps if no conversion is needed.
Map<String, dynamic> _convertMap(dynamic map) {
  if (map is Map<String, dynamic>) {
    Map<String, dynamic>? newMap;
    for (final entry in map.entries) {
      final value = entry.value;
      if (value is Map) {
        final convertedValue = _convertMap(value);
        if (convertedValue != value) {
          newMap ??= Map<String, dynamic>.of(map);
          newMap[entry.key] = convertedValue;
        }
      }
    }
    return newMap ?? map;
  }

  final convertedMap = Map<String, dynamic>.from(map as Map);

  for (final key in convertedMap.keys) {
    final value = convertedMap[key];
    if (value is Map) {
      convertedMap[key] = _convertMap(value);
    }
  }

  return convertedMap;
}
