import '../models/message.dart';
import 'chat_operation.dart';

/// Abstract interface for managing the state of chat messages.
///
/// Implementations handle message insertion, updates, removal, and retrieval.
/// It also provides a stream of [ChatOperation]s to notify listeners (like the UI)
/// about changes to the message list.
abstract class ChatController {
  /// Inserts a new [message] into the list, optionally at a specific [index].
  ///
  /// The [index] refers to the position in the underlying content list (where 0
  /// is typically the oldest message and `messages.length - 1` is the newest).
  ///
  /// - To add a new message that should appear at the visual end of the chat
  ///   (bottom for both normal and reversed lists), call this method without an
  ///   `index` or with `index` equal to the current number of messages.
  ///   The controller will typically append the message.
  /// - To prepend messages (e.g., loading older history that should appear at the
  ///   visual top), pass `index: 0`.
  Future<void> insertMessage(Message message, {int? index});

  /// Inserts a list of [messages] into the chat, starting at the specified [index].
  ///
  /// The [index] refers to the position in the underlying content list where the
  /// first message in the [messages] list should be inserted. Subsequent messages
  /// in the list will follow sequentially.
  ///
  /// - Use this for batch insertions, like loading a page of older messages
  ///   or adding multiple new messages at once.
  /// - The controller should emit a `ChatOperation.insertAll(messages, index)`
  ///   to notify listeners.
  /// - Note: For simpler persistence layers (e.g., basic key-value stores) that
  ///   don't inherently support ordered list insertions at an arbitrary index,
  ///   ensuring that a subsequent call to `this.messages` reflects the correct
  ///   logical order after an indexed `insertAllMessages` operation might require
  ///   storing and sorting by an explicit order field (e.g., a createdAt or a
  ///   sequence number) within the controller's implementation.
  Future<void> insertAllMessages(List<Message> messages, {int? index});

  /// Replaces an [oldMessage] with a [newMessage].
  ///
  /// When implementing, the `oldMessage` parameter might refer to an outdated
  /// instance of the message if it has been updated elsewhere (e.g., an image
  /// message getting its dimensions). To ensure correctness:
  /// 1. Identify the message in your data store using `oldMessage.id`.
  /// 2. Retrieve the *current* version of that message from your store (this is
  ///    the true 'before' state).
  /// 3. The emitted `ChatOperation.update(currentOldMessageFromStore, newMessage)`
  ///    must use this `currentOldMessageFromStore` and the `newMessage`.
  Future<void> updateMessage(Message oldMessage, Message newMessage);

  /// Removes a specific [message] from the list.
  /// The [message] parameter is used to identify the message to be removed,
  /// typically by its `id`.
  ///
  /// When implementing, the `message` parameter might refer to an outdated
  /// instance if it has been updated elsewhere. To ensure correctness:
  /// 1. Identify the message in your data store using `message.id`.
  /// 2. Retrieve the *current* version of that message from your store.
  /// 3. The emitted `ChatOperation.remove(currentMessageFromStore, index)`
  ///    must use this `currentMessageFromStore` and its `index` (position
  ///    before removal).
  Future<void> removeMessage(Message message);

  /// Replaces the entire message list with the provided [messages].
  Future<void> setMessages(List<Message> messages);

  /// Gets the current list of messages.
  List<Message> get messages;

  /// A stream that emits [ChatOperation] objects whenever the message list changes.
  /// UI components can listen to this stream to react to updates.
  Stream<ChatOperation> get operationsStream;

  /// Releases resources used by the controller (e.g., closes streams).
  void dispose();
}
