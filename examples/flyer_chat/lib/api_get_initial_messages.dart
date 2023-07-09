import 'package:dio/dio.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';

Future<List<Message>> getInitialMessages(Dio dio) async {
  final response = await dio.get<Map<String, dynamic>>(
    'https://whatever.diamanthq.dev/message',
  );

  final data = response.data?['data'] as List<dynamic>? ?? [];
  final mappedData = data.map((e) => Message.fromJson(e));

  return mappedData.toList();
}
