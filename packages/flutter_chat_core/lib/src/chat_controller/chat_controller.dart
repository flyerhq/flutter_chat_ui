import '../models/message.dart';
import 'chat_operation.dart';

/// Abstract interface for managing the state of chat messages.
///
/// Implementations handle message insertion, updates, removal, and retrieval.
/// It also provides a stream of [ChatOperation]s to notify listeners (like the UI)
/// about changes to the message list.
abstract class ChatController {
  /// Inserts a new [message] into the list, optionally at a specific [index].
  Future<void> insert(Message message, {int? index});

  /// Replaces an [oldMessage] with a [newMessage].
  Future<void> update(Message oldMessage, Message newMessage);

  /// Removes a specific [message] from the list.
  Future<void> remove(Message message);

  /// Replaces the entire message list with the provided [messages].
  Future<void> set(List<Message> messages);

  /// Gets the current list of messages.
  List<Message> get messages;

  /// A stream that emits [ChatOperation] objects whenever the message list changes.
  /// UI components can listen to this stream to react to updates.
  Stream<ChatOperation> get operationsStream;

  /// Releases resources used by the controller (e.g., closes streams).
  void dispose();
}
