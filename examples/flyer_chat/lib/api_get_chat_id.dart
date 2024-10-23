import 'package:dio/dio.dart';

Future<String> getChatId(Dio dio) async {
  try {
    final response = await dio.post<Map<String, dynamic>>(
      'https://whatever.diamanthq.dev/chat',
    );

    final data = response.data?['chat_id'] as String? ?? '';

    return data;
  } catch (e) {
    rethrow;
  }
}
