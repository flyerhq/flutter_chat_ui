import 'package:dio/dio.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';

class ApiService {
  final String baseUrl;
  final String chatId;
  final Dio dio;

  ApiService({required this.baseUrl, required this.chatId, required this.dio});

  Future<Map<String, dynamic>> send(Message message) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '$baseUrl/chat/$chatId/message',
        data: message.toJson(),
      );
      return response.data!;
    } catch (e) {
      throw 'Failed to send message: $e';
    }
  }

  Future<void> delete(Message message) async {
    try {
      await dio.delete(
        '$baseUrl/chat/$chatId/message',
        data: {'id': message.id},
      );
    } catch (e) {
      throw 'Failed to delete message: $e';
    }
  }

  Future<void> flush() async {
    try {
      await dio.post('$baseUrl/chat/$chatId/message-flush');
    } catch (e) {
      throw 'Failed to flush messages: $e';
    }
  }
}
