import 'dart:async';

import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:sembast/sembast.dart';

class SembastChatController implements ChatController {
  final Database database;
  final _operationsController = StreamController<ChatOperation>.broadcast();

  SembastChatController(this.database);

  @override
  Future<void> insertMessage(Message message, {int? index}) async {
    final store = intMapStoreFactory.store();

    final record = await store.findFirst(
      database,
      finder: Finder(
        filter: Filter.custom((record) => record['id'] == message.id),
      ),
    );

    if (record != null) return;

    if (index == null) {
      await store.add(database, message.toJson());
      final length = await store.count(database);
      _operationsController.add(ChatOperation.insert(message, length - 1));
    } else {
      await store.record(index).update(database, message.toJson());
      _operationsController.add(ChatOperation.insert(message, index));
    }
  }

  @override
  Future<void> insertAllMessages(List<Message> messages, {int? index}) async {
    // Implementing a fully order-preserving `insertAllMessages` at an arbitrary `index`
    // that also ensures `this.messages` getter returns the Sembast data in that
    // specific logical order is complex for this simple example controller.
    // It would typically require managing an explicit order field within Sembast
    // and sorting by it, or significant data shifting.
    //
    // For this example, if batch insertion is needed with Sembast, users might:
    // 1. Implement a more sophisticated ordering mechanism (e.g., sort by createdAt
    //    or a dedicated order field, and adjust that field on insertAll).
    // 2. Rely on the UI to manage the visual order based on ChatOperation.insertAll,
    //    understanding that `this.messages` will return Sembast's key-based order.
    // 3. Use `setMessages` if the goal is to completely replace the list.
    //
    // This method is marked UnimplementedError to highlight this complexity.
    // The `index` parameter, if not null, would guide where the UI should
    // visually place the messages.
    throw UnimplementedError(
      'SembastChatController.insertAllMessages with arbitrary index is not fully implemented due to ordering complexities with Sembast in this simple example. See comments in code.',
    );
  }

  @override
  Future<void> removeMessage(Message message) async {
    final store = intMapStoreFactory.store();
    final records = await store.find(database);

    int? index;
    RecordSnapshot<int, Map<String, Object?>>? record;

    for (var i = 0; i < records.length; i++) {
      if (records[i].value['id'] == message.id) {
        index = i;
        record = records[i];
        break;
      }
    }

    if (index != null && record != null) {
      final messageToRemove = Message.fromJson(record.value);
      await store.record(record.key).delete(database);
      _operationsController.add(ChatOperation.remove(messageToRemove, index));
    }
  }

  @override
  Future<void> updateMessage(Message oldMessage, Message newMessage) async {
    final store = intMapStoreFactory.store();

    final record = await store.findFirst(
      database,
      finder: Finder(
        filter: Filter.custom((record) => record['id'] == oldMessage.id),
      ),
    );

    if (record != null) {
      final actualOldMessage = Message.fromJson(record.value);

      if (actualOldMessage == newMessage) {
        return;
      }

      await store.record(record.key).update(database, newMessage.toJson());
      _operationsController.add(
        ChatOperation.update(actualOldMessage, newMessage),
      );
    }
  }

  @override
  Future<void> setMessages(List<Message> messages) async {
    final store = intMapStoreFactory.store();
    await store.delete(database);
    for (final message in messages) {
      await store.add(database, message.toJson());
    }
    _operationsController.add(ChatOperation.set(messages: messages));
  }

  @override
  List<Message> get messages {
    final store = intMapStoreFactory.store();
    final records = store.findSync(database);
    return records.map((record) => Message.fromJson(record.value)).toList();
  }

  @override
  Stream<ChatOperation> get operationsStream => _operationsController.stream;

  @override
  void dispose() {
    _operationsController.close();
  }
}
