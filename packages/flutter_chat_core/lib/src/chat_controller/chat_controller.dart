import '../models/message.dart';
import 'chat_operation.dart';

abstract class ChatController {
  Future<void> insert(Message message, {int? index});
  Future<void> update(Message oldMessage, Message newMessage);
  Future<void> remove(Message message);
  Future<void> set(List<Message> messages);

  List<Message> get messages;

  Stream<ChatOperation> get operationsStream;

  void dispose();
}
