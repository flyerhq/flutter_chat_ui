import 'dart:async';

import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:hive_ce/hive.dart';

class HiveChatController
    with UploadProgressMixin, ScrollToMessageMixin
    implements ChatController {
  final _box = Hive.box('chat');
  final _operationsController = StreamController<ChatOperation>.broadcast();

  @override
  Future<void> insertMessage(Message message, {int? index}) async {
    if (_box.containsKey(message.id)) return;

    // Index is ignored because Hive does not maintain order
    await _box.put(message.id, message.toJson());
    _operationsController.add(ChatOperation.insert(message, _box.length - 1));
  }

  @override
  Future<void> removeMessage(Message message) async {
    final sortedMessages = List.from(messages);
    final index = sortedMessages.indexWhere((m) => m.id == message.id);

    if (index != -1) {
      final messageToRemove = sortedMessages[index];
      await _box.delete(messageToRemove.id);
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
      _operationsController.add(
        ChatOperation.update(actualOldMessage, newMessage, index),
      );
    }
  }

  @override
  Future<void> setMessages(List<Message> messages) async {
    await _box.clear();
    if (messages.isEmpty) {
      _operationsController.add(ChatOperation.set());
      return;
    } else {
      await _box.putAll(
        messages
            .map((message) => {message.id: message.toJson()})
            .toList()
            .reduce((acc, map) => {...acc, ...map}),
      );
      _operationsController.add(ChatOperation.set(messages: messages));
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
    _operationsController.add(
      ChatOperation.insertAll(messages, originalLength),
    );
  }

  @override
  List<Message> get messages =>
      _box.values.map((json) => Message.fromJson(json)).toList()..sort(
        (a, b) => (a.createdAt?.millisecondsSinceEpoch ?? 0).compareTo(
          b.createdAt?.millisecondsSinceEpoch ?? 0,
        ),
      );

  @override
  Stream<ChatOperation> get operationsStream => _operationsController.stream;

  @override
  void dispose() {
    _operationsController.close();
    disposeUploadProgress();
    disposeScrollMethods();
  }
}
