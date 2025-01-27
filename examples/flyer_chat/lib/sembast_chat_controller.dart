import 'dart:async';

import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:sembast/sembast.dart';

class SembastChatController implements ChatController {
  final Database database;
  final _operationsController = StreamController<ChatOperation>.broadcast();

  SembastChatController(this.database);

  @override
  Future<void> insert(Message message, {int? index}) async {
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
      _operationsController.add(
        ChatOperation.insert(message, length - 1),
      );
    } else {
      await store.record(index).update(database, message.toJson());
      _operationsController.add(ChatOperation.insert(message, index));
    }
  }

  @override
  Future<void> remove(Message message) async {
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
      await store.record(record.key).delete(database);
      _operationsController.add(ChatOperation.remove(message, index));
    }
  }

  @override
  Future<void> update(Message oldMessage, Message newMessage) async {
    if (oldMessage == newMessage) return;

    final store = intMapStoreFactory.store();

    final record = await store.findFirst(
      database,
      finder: Finder(
        filter: Filter.custom((record) => record['id'] == oldMessage.id),
      ),
    );

    if (record != null) {
      await store.record(record.key).update(database, newMessage.toJson());
      _operationsController.add(ChatOperation.update(oldMessage, newMessage));
    }
  }

  @override
  Future<void> set(List<Message> messages) async {
    final store = intMapStoreFactory.store();
    await store.delete(database);
    _operationsController.add(ChatOperation.set());
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
