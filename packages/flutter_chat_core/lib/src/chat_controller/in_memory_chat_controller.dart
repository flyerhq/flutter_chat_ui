import 'dart:async';

import '../models/message.dart';
import 'chat_controller.dart';
import 'chat_operation.dart';
import 'scroll_to_message_mixin.dart';
import 'upload_progress_mixin.dart';

class InMemoryChatController
    with UploadProgressMixin, ScrollToMessageMixin
    implements ChatController {
  List<Message> _messages;
  final _operationsController = StreamController<ChatOperation>.broadcast();

  InMemoryChatController({List<Message>? messages})
    : _messages = messages ?? [] {
    // Check for duplicate IDs in the initial messages
    _assertNoMessageIdDuplicates(_messages, 'initialization');
  }

  // Checks for duplicate message IDs in a list of messages
  void _assertNoMessageIdDuplicates(
    List<Message> messages, [
    String operation = 'operation',
  ]) {
    assert(() {
      final seen = <String>{};
      for (final message in messages) {
        if (seen.contains(message.id)) {
          throw ArgumentError(
            'InMemoryChatController found duplicate message ID: ${message.id} during $operation. '
            'Each message must have a unique ID to ensure proper rendering and animations.',
          );
        }
        seen.add(message.id);
      }
      return true;
    }(), 'Messages must have unique IDs');
  }

  @override
  Future<void> insert(Message message, {int? index}) async {
    if (_messages.contains(message)) return;

    // Check if this message ID already exists in the list
    assert(() {
      if (_messages.any((m) => m.id == message.id)) {
        throw ArgumentError(
          'InMemoryChatController: Cannot insert message with duplicate ID: ${message.id}. '
          'Each message must have a unique ID to ensure proper rendering and animations.',
        );
      }
      return true;
    }(), 'Message ID must be unique');

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
    _assertNoMessageIdDuplicates(messages, 'set');
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
    disposeUploadProgress();
    disposeScrollMethods();
  }
}
