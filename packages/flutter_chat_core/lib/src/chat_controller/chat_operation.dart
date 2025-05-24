import '../models/message.dart';

/// Enum representing the type of operation performed on the chat message list.
enum ChatOperationType { insert, insertAll, update, remove, set }

/// Represents a single operation performed on the message list managed by a [ChatController].
///
/// Instances of this class are emitted by the [ChatController.operationsStream]
/// to notify listeners about changes.
class ChatOperation {
  /// The type of operation performed.
  final ChatOperationType type;

  /// The message before an update operation. Null for other types.
  final Message? oldMessage;

  /// The affected message (inserted, updated, removed). Null for `set` or `insertAll`.
  final Message? message;

  /// The index where the message was inserted or removed. Null for `update` and `set`.
  /// For `insertAll`, this is the starting index of the insertion.
  final int? index;

  /// A list of messages, used by `insertAll` and `set` operations.
  /// Null for other operation types.
  final List<Message>? messages;

  ChatOperation._(
    this.type, {
    this.oldMessage,
    this.message,
    this.index,
    this.messages,
  });

  /// Creates an insert operation.
  factory ChatOperation.insert(Message message, int index) =>
      ChatOperation._(ChatOperationType.insert, message: message, index: index);

  /// Creates an insertAll operation, for inserting multiple messages at a specified index.
  factory ChatOperation.insertAll(List<Message> messages, int index) =>
      ChatOperation._(
        ChatOperationType.insertAll,
        messages: messages,
        index: index,
      );

  /// Creates an update operation.
  factory ChatOperation.update(
    Message oldMessage,
    Message message,
    int index,
  ) => ChatOperation._(
    ChatOperationType.update,
    oldMessage: oldMessage,
    message: message,
    index: index,
  );

  /// Creates a remove operation.
  factory ChatOperation.remove(Message message, int index) =>
      ChatOperation._(ChatOperationType.remove, message: message, index: index);

  /// Creates a set operation (signifying a full list replacement).
  ///
  /// The [messages] parameter contains the new list of messages. Passing an empty list
  /// signifies that the chat list should be cleared.
  factory ChatOperation.set(List<Message> messages) =>
      ChatOperation._(ChatOperationType.set, messages: messages);
}
