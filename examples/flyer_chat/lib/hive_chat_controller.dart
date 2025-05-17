import 'dart:async';

import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:hive/hive.dart';

class HiveChatController implements ChatController {
  final _box = Hive.box(name: 'chat');
  final _operationsController = StreamController<ChatOperation>.broadcast();

  @override
  Future<void> insertMessage(Message message, {int? index}) async {
    if (_box.containsKey(message.id)) return;

    _box.write(() {
      if (index == null) {
        _box.put(message.id, message.toJson());
        _operationsController.add(
          ChatOperation.insert(message, _box.length - 1),
        );
      } else {
        _box.putAt(index, message.toJson());
        _operationsController.add(ChatOperation.insert(message, index));
      }
    });
  }

  @override
  Future<void> removeMessage(Message message) async {
    final messages =
        _box
            .getRange(0, _box.length)
            .map((json) => Message.fromJson(json))
            .toList();

    final index = messages.indexWhere((m) => m.id == message.id);

    if (index != -1) {
      final messageToRemove = messages[index];
      _box.write(() {
        _box.deleteAt(index);
        _operationsController.add(ChatOperation.remove(messageToRemove, index));
      });
    }
  }

  @override
  Future<void> updateMessage(Message oldMessage, Message newMessage) async {
    final messages =
        _box
            .getRange(0, _box.length)
            .map((json) => Message.fromJson(json))
            .toList();

    final index = messages.indexWhere((m) => m.id == oldMessage.id);

    if (index != -1) {
      final actualOldMessage = messages[index];

      if (actualOldMessage == newMessage) {
        return;
      }

      _box.write(() {
        _box.putAt(index, newMessage.toJson());
        _operationsController.add(
          ChatOperation.update(actualOldMessage, newMessage, index),
        );
      });
    }
  }

  @override
  Future<void> setMessages(List<Message> messages) async {
    _box.clear();
    if (messages.isEmpty) {
      _operationsController.add(ChatOperation.set());
      return;
    } else {
      _box.write(() {
        _box.putAll(
          messages
              .map((message) => {message.id: message.toJson()})
              .toList()
              .reduce((acc, map) => {...acc, ...map}),
        );
        _operationsController.add(ChatOperation.set(messages: messages));
      });
    }
  }

  @override
  Future<void> insertAllMessages(List<Message> messages, {int? index}) async {
    // Implementing a fully order-preserving `insertAllMessages` at an arbitrary `index`
    // that also ensures `this.messages` (derived from _box.getRange) reflects that
    // specific logical order is complex for this simple example controller, especially
    // if performance with large datasets is a concern (e.g., avoiding read-all,
    // modify-list, clear-box, write-all).
    //
    // For this example, if batch insertion is needed with Hive, users might:
    // 1. Implement a more sophisticated strategy, potentially involving managing order
    //    explicitly if Hive's natural order (based on put/putAt) isn't sufficient
    //    for their exact needs after complex indexed insertions.
    // 2. Rely on the UI to manage the visual order based on ChatOperation.insertAll,
    //    understanding that `this.messages` will reflect Hive's current stored order.
    // 3. Use `setMessages` if the goal is to completely replace the list.
    //
    // This method is marked UnimplementedError to highlight this complexity.
    // The `index` parameter, if not null, would guide where the UI should
    // visually place the messages.
    throw UnimplementedError(
      'HiveChatController.insertAllMessages with arbitrary index is not fully implemented due to ordering and performance complexities with Hive in this simple example. See comments in code.',
    );
  }

  @override
  List<Message> get messages {
    return _box
        .getRange(0, _box.length)
        .map((json) => Message.fromJson(json))
        .toList();
  }

  @override
  Stream<ChatOperation> get operationsStream => _operationsController.stream;

  @override
  void dispose() {
    _operationsController.close();
  }
}
