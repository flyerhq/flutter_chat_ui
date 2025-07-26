import 'dart:math';

import 'package:flutter_chat_core/flutter_chat_core.dart';

const _mockDatabaseDelay = Duration(milliseconds: 500);

class MockDatabase {
  static final _messages = List.generate(100, (i) {
    final random = Random();
    final numLines = random.nextInt(4) + 1;
    final text = List.generate(
      numLines,
      (lineIndex) => 'Message ${i + 1} - Line ${lineIndex + 1}',
    ).join('\n');
    return Message.text(
      id: (i + 1).toString(),
      authorId: 'me',
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        1736893310000 - ((100 - i) * 1000),
        isUtc: true,
      ),
      text: text,
    );
  });

  static final List<Message> initialNewerMessages = _messages
      .take(20)
      .toList()
      .reversed
      .toList();

  static final List<Message> initialOlderMessages = _messages
      .skip(80)
      .take(20)
      .toList()
      .reversed
      .toList();

  static Future<List<Message>> getOlderMessages({
    required int limit,
    MessageID? lastMessageId,
  }) async {
    await Future.delayed(_mockDatabaseDelay);

    final start = lastMessageId == null
        ? 20
        : _messages.indexWhere((m) => m.id == lastMessageId) + 1;

    if (start >= _messages.length) return [];

    return _messages.skip(start).take(limit).toList().reversed.toList();
  }

  static Future<List<Message>> getNewerMessages({
    required int limit,
    MessageID? newestMessageId,
  }) async {
    await Future.delayed(_mockDatabaseDelay);
    final end = newestMessageId == null
        ? 80
        : _messages.indexWhere((m) => m.id == newestMessageId);

    if (end <= 0) return [];

    final start = (end - limit).clamp(0, end);

    return _messages.sublist(start, end).reversed.toList();
  }
}
