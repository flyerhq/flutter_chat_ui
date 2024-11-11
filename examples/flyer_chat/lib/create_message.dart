import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:uuid/uuid.dart';

enum MessageType { text, image, audio }

Future<Message> createMessage(
  User author,
  Dio dio, {
  MessageType type = MessageType.text,
  String? text,
  File? file,
}) async {
  const uuid = Uuid();

  switch (type) {
    case MessageType.text:
      return TextMessage(
        id: uuid.v4(),
        author: author,
        createdAt: DateTime.now().toUtc(),
        text: text ?? lorem(paragraphs: 1, words: Random().nextInt(30) + 1),
      );
    case MessageType.image:
      final orientation = ['portrait', 'square', 'wide'][Random().nextInt(3)];
      late double width, height;

      if (orientation == 'portrait') {
        width = 200;
        height = 400;
      } else if (orientation == 'square') {
        width = 200;
        height = 200;
      } else {
        width = 400;
        height = 200;
      }

      final response = await dio.get(
        'https://whatever.diamanthq.dev/image?w=${width.toInt()}&h=${height.toInt()}&seed=${Random().nextInt(501)}',
        options: Options(
          headers: {
            'Access-Control-Allow-Origin': '*',
            'Content-Type': 'application/json',
            'Accept': '*/*',
          },
        ),
      );

      return ImageMessage(
        id: uuid.v4(),
        author: author,
        createdAt: DateTime.now().toUtc(),
        source: response.data['img'],
        thumbhash: response.data['thumbhash'],
        blurhash: response.data['blurhash'],
      );
    case MessageType.audio:
      if (file != null) {
        return AudioMessage(
          id: uuid.v4(),
          author: author,
          createdAt: DateTime.now().toUtc(),
          audioFile: file.path,
        );
      } else {
        throw ArgumentError('File must be provided for audio messages');
      }
    default:
      throw ArgumentError('Invalid message type: $type');
  }
}
