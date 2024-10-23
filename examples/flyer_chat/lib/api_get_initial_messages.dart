import 'package:dio/dio.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';

Future<List<Message>> getInitialMessages(
  Dio dio, {
  required String chatId,
}) async {
  try {
    final response = await dio.get<Map<String, dynamic>>(
      'https://whatever.diamanthq.dev/chat/$chatId/message',
    );

    final data = response.data?['data'] as List<dynamic>? ?? [];
    final mappedData = data.map((e) => Message.fromJson(e));

    return mappedData.toList();
  } catch (e) {
    rethrow;
  }
}
