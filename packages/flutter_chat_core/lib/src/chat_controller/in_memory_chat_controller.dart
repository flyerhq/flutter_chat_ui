import 'dart:async';

import '../models/message.dart';
import 'chat_controller.dart';
import 'chat_operation.dart';

class InMemoryChatController implements ChatController {
  List<Message> _messages;
  final _operationsController = StreamController<ChatOperation>.broadcast();

  InMemoryChatController({List<Message>? messages})
      : _messages = messages ?? [];

  @override
  Future<void> insert(Message message, {int? index}) async {
    if (_messages.contains(message)) return;

    if (index == null) {
      _messages.add(message);
      _operationsController.add(
        ChatOperation.insert(message, _messages.length - 1),
      );
    } else {
      _messages.insert(index, message);
      _operationsController.add(ChatOperation.insert(message, index));
    }
  }

  @override
  Future<void> remove(Message message) async {
    final index = _messages.indexOf(message);

    if (index > -1) {
      _messages.removeAt(index);
      _operationsController.add(ChatOperation.remove(message, index));
    }
  }

  @override
  Future<void> update(Message oldMessage, Message newMessage) async {
    if (oldMessage == newMessage) return;

    final index = _messages.indexOf(oldMessage);

    if (index > -1) {
      _messages[index] = newMessage;
      _operationsController.add(ChatOperation.update(oldMessage, newMessage));
    }
  }

  @override
  Future<void> set(List<Message> messages) async {
    _messages = messages;
    _operationsController.add(ChatOperation.set());
  }

  @override
  List<Message> get messages => _messages;

  @override
  Stream<ChatOperation> get operationsStream => _operationsController.stream;

  @override
  void dispose() {
    _operationsController.close();
  }
}
