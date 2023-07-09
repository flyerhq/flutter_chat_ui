import 'dart:async';

import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:hive/hive.dart';

class HiveChatController implements ChatController {
  final _box = Hive.box(name: 'chat');
  final _operationsController = StreamController<ChatOperation>.broadcast();

  @override
  Future<void> insert(Message message, {int? index}) async {
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
  Future<void> remove(Message message) async {
    final index = _box
        .getRange(0, _box.length)
        .map((json) => Message.fromJson(json))
        .toList()
        .indexOf(message);

    if (index > -1) {
      _box.write(() {
        _box.deleteAt(index);
        _operationsController.add(ChatOperation.remove(message, index));
      });
    }
  }

  @override
  Future<void> update(Message oldMessage, Message newMessage) async {
    if (oldMessage == newMessage) return;

    final index = _box
        .getRange(0, _box.length)
        .map((json) => Message.fromJson(json))
        .toList()
        .indexOf(oldMessage);

    if (index > -1) {
      _box.write(() {
        _box.putAt(index, newMessage.toJson());
        _operationsController.add(ChatOperation.update(oldMessage, newMessage));
      });
    }
  }

  @override
  Future<void> set(List<Message> messages) async {
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
        _operationsController.add(ChatOperation.set());
      });
    }
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
