import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:uuid/uuid.dart';

Future<Message> createMessage(
  UserID authorId,
  Dio dio, {
  bool? textOnly,
  bool? localOnly,
  String? text,
}) async {
  const uuid = Uuid();
  Message message;

  final randomType = Random().nextInt(3) + 1; // 1, 2, or 3

  if (randomType == 1 || textOnly == true || text != null) {
    message = TextMessage(
      id: uuid.v4(),
      authorId: authorId,
      createdAt: DateTime.now().toUtc(),
      sentAt: localOnly == true ? DateTime.now().toUtc() : null,
      text: text ?? lorem(paragraphs: 1, words: Random().nextInt(30) + 1),
      metadata: isOnlyEmoji(text ?? '') ? {'isOnlyEmoji': true} : null,
    );
  } else {
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

    if (randomType == 2) {
      message = ImageMessage(
        id: uuid.v4(),
        authorId: authorId,
        createdAt: DateTime.now().toUtc(),
        sentAt: localOnly == true ? DateTime.now().toUtc() : null,
        source: response.data['img'],
        thumbhash: response.data['thumbhash'],
        blurhash: response.data['blurhash'],
      );
    } else {
      message = FileMessage(
        id: uuid.v4(),
        name: 'image.png',
        authorId: authorId,
        createdAt: DateTime.now().toUtc(),
        sentAt: localOnly == true ? DateTime.now().toUtc() : null,
        source: response.data['img'],
        size: 1000000,
      );
    }
  }

  // return ImageMessage(
  //   id: uuid.v4(),
  //   author: author,
  //   createdAt: DateTime.now().toUtc(),
  //   sentAt: localOnly == true ? DateTime.now().toUtc() : null,
  //   source:
  //       'https://www.hdcarwallpapers.com/walls/audi_r8_spyder_v10_performance_rwd_2021_4k_8k-HD.jpg',
  //   thumbhash: '2gcODIKwdmg9eId1l4qTb2v4xw',
  //   blurhash: 'LPFFjU00^+IV~W4n%LRkROM|WBxu',
  // );

  return message;
}
