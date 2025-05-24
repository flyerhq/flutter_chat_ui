import 'dart:async';

import '../models/message.dart';
import 'chat_controller.dart';
import 'chat_operation.dart';
import 'scroll_to_message_mixin.dart';
import 'upload_progress_mixin.dart';

/// A basic [ChatController] implementation that stores messages in memory.
///
/// This controller does not persist messages across app restarts.
/// It includes [UploadProgressMixin] for upload progress tracking and
/// [ScrollToMessageMixin] for programmatic scrolling.
///
/// **Important:** Ensures that all message IDs are unique during initialization
/// and insertion to prevent issues with animations and state management.
class InMemoryChatController
    with UploadProgressMixin, ScrollToMessageMixin
    implements ChatController {
  List<Message> _messages;
  final _operationsController = StreamController<ChatOperation>.broadcast();

  /// Creates an in-memory chat controller.
  /// Optionally initializes with a list of [messages].
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
  Future<void> insertMessage(Message message, {int? index}) async {
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
  Future<void> insertAllMessages(List<Message> messages, {int? index}) async {
    if (messages.isEmpty) return;

    // Check for duplicates within the incoming list and against existing messages
    _assertNoMessageIdDuplicates(messages, 'insertAllMessages (incoming list)');
    assert(() {
      final existingIds = _messages.map((m) => m.id).toSet();
      for (final message in messages) {
        if (existingIds.contains(message.id)) {
          throw ArgumentError(
            'InMemoryChatController: Cannot insertAllMessages, message with ID: ${message.id} already exists. '
            'Each message must have a unique ID.',
          );
        }
      }
      return true;
    }(), 'Incoming message IDs must not already exist in the controller');

    if (index == null) {
      final originalLength = _messages.length;
      _messages.addAll(messages);
      _operationsController.add(
        ChatOperation.insertAll(messages, originalLength),
      );
    } else {
      _messages.insertAll(index, messages);
      _operationsController.add(ChatOperation.insertAll(messages, index));
    }
  }

  @override
  Future<void> removeMessage(Message message) async {
    final index = _messages.indexWhere((m) => m.id == message.id);

    if (index != -1) {
      // Get the actual message instance from the list before removing it.
      final messageToRemove = _messages[index];
      _messages.removeAt(index); // Remove from the internal list

      // Emit the operation with the actual message instance from the list and its original index.
      _operationsController.add(ChatOperation.remove(messageToRemove, index));
    }
  }

  @override
  Future<void> updateMessage(Message oldMessage, Message newMessage) async {
    final index = _messages.indexWhere((m) => m.id == oldMessage.id);

    if (index != -1) {
      final actualOldMessage = _messages[index];

      // If the newMessage is identical to what's already in the list for that ID,
      // no actual update is needed, and no operation should be emitted.
      if (actualOldMessage == newMessage) {
        return;
      }

      _messages[index] = newMessage;
      // Emit the operation with the state *before* this update and the new state.
      _operationsController.add(
        ChatOperation.update(actualOldMessage, newMessage, index),
      );
    }
  }

  @override
  Future<void> setMessages(List<Message> messages) async {
    _assertNoMessageIdDuplicates(messages, 'set');
    _messages = List.from(messages);
    _operationsController.add(ChatOperation.set(_messages));
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
