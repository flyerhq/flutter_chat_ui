import '../models/message.dart';

enum ChatOperationType { insert, update, remove, set }

class ChatOperation {
  final ChatOperationType type;
  final Message? oldMessage;
  final Message? message;
  final int? index;

  ChatOperation._(this.type, {this.oldMessage, this.message, this.index});

  factory ChatOperation.insert(Message message, int index) => ChatOperation._(
        ChatOperationType.insert,
        message: message,
        index: index,
      );

  factory ChatOperation.update(Message oldMessage, Message message) =>
      ChatOperation._(
        ChatOperationType.update,
        oldMessage: oldMessage,
        message: message,
      );

  factory ChatOperation.remove(Message message, int index) => ChatOperation._(
        ChatOperationType.remove,
        message: message,
        index: index,
      );

  factory ChatOperation.set() => ChatOperation._(ChatOperationType.set);
}
