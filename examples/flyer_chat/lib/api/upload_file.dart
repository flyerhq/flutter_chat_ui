import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:http/http.dart' as http;

// Dio has problems with tracking upload progress, so we use http here
// https://github.com/cfug/dio/issues/925
Future<Map<String, dynamic>> uploadFile(
  String path,
  List<int> bytes,
  String id,
  ChatController chatController,
) async {
  final uri = Uri.parse('https://whatever.diamanthq.dev/upload');

  // Generate a boundary
  final boundary = base64.encode(
    List<int>.generate(32, (_) => Random().nextInt(256)),
  );

  // Create the request
  final request = http.MultipartRequest('POST', uri);

  // Add the file
  final multipartFile = http.MultipartFile(
    'blob',
    trackProgress(bytes, id: id, chatController: chatController),
    bytes.length,
    filename: path.split('/').last,
  );

  // Add fields to the request
  request.fields['format'] = 'img';
  request.files.add(multipartFile);

  // Set the content type with boundary
  request.headers['content-type'] = 'multipart/form-data; boundary=$boundary';

  // Add timeout
  final client = http.Client();
  try {
    // Send the request with progress tracking
    final streamedResponse = await request.send().timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw TimeoutException('Upload timed out after 30 seconds');
      },
    );

    // Get the response
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      final errorBody = json.decode(response.body);
      throw Exception(
        'Upload failed with status: ${response.statusCode}. Response: $errorBody',
      );
    }

    return json.decode(response.body) as Map<String, dynamic>;
  } finally {
    client.close();
  }
}

Stream<List<int>> trackProgress(
  List<int> bytes, {
  required String id,
  required ChatController chatController,
}) async* {
  if (bytes.isEmpty) {
    throw Exception('Cannot upload empty file');
  }

  try {
    num uploaded = 0;
    const chunkSize = 1024 * 64; // 64KB chunks
    final total = bytes.length;

    for (var i = 0; i < total; i += chunkSize) {
      final end = (i + chunkSize).clamp(0, total);
      final chunk = bytes.sublist(i, end);

      uploaded += chunk.length;
      if (chatController is UploadProgressMixin) {
        final progress = uploaded / total;
        (chatController as UploadProgressMixin).updateUploadProgress(
          id,
          progress,
        );
      }

      yield chunk;
    }
  } catch (e) {
    if (chatController is UploadProgressMixin) {
      (chatController as UploadProgressMixin).updateUploadProgress(id, 1);
    }
    rethrow;
  }
}
