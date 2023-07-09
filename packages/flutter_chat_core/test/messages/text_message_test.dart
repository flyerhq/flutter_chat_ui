import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TextMessage', () {
    late TextMessage message;

    setUp(() {
      final json = {
        'id': '1',
        'senderId': 'sender1',
        'timestamp': 1621267200000, // in milliseconds
        'type': 'text',
        'text': 'Hello, world!',
        'metadata': {'key': 'value'},
        'linkPreview': {
          'title': 'Google',
          'description': 'Google homepage',
          'imageUrl': 'https://google.com/logo.png',
          'link': 'https://google.com',
        },
      };

      message = TextMessage.fromJson(json);
    });

    test('initializes correctly from a JSON', () {
      expect(message.id, '1');
      expect(message.senderId, 'sender1');
      expect(
        message.timestamp,
        DateTime.fromMillisecondsSinceEpoch(1621267200000, isUtc: true),
      );
      expect(message.text, 'Hello, world!');
      expect(message.metadata, {'key': 'value'});
      expect(message.linkPreview!.title, 'Google');
      expect(message.linkPreview!.description, 'Google homepage');
      expect(message.linkPreview!.imageUrl, 'https://google.com/logo.png');
      expect(message.linkPreview!.link, 'https://google.com');
    });

    test('converts correctly to a JSON', () {
      expect(message.toJson(), {
        'id': '1',
        'senderId': 'sender1',
        'timestamp': 1621267200000,
        'type': 'text',
        'text': 'Hello, world!',
        'metadata': {'key': 'value'},
        'linkPreview': {
          'title': 'Google',
          'description': 'Google homepage',
          'imageUrl': 'https://google.com/logo.png',
          'link': 'https://google.com',
        },
      });
    });

    test('JSON serialization is symmetrical', () {
      final messageJson = message.toJson();
      final messageFromJson = TextMessage.fromJson(messageJson);
      expect(messageFromJson.toJson(), messageJson);
    });

    test('creates a correct copy with new values through copyWith', () {
      final copiedMessage = message.copyWith(
        timestamp: DateTime.fromMillisecondsSinceEpoch(
          1621267200000 + 10000,
          isUtc: true,
        ),
        metadata: {'key': 'newValue'},
        text: 'New text',
        linkPreview: const LinkPreview(
          title: 'New Title',
          description: 'New description',
          imageUrl: 'https://newwebsite.com/logo.png',
          link: 'https://newwebsite.com',
        ),
      );

      // Assert all properties
      expect(copiedMessage.id, '1');
      expect(copiedMessage.senderId, 'sender1');
      expect(
        copiedMessage.timestamp,
        DateTime.fromMillisecondsSinceEpoch(1621267200000 + 10000, isUtc: true),
      );
      expect(copiedMessage.text, 'New text');
      expect(copiedMessage.metadata, {'key': 'newValue'});
      expect(copiedMessage.linkPreview!.title, 'New Title');
      expect(copiedMessage.linkPreview!.description, 'New description');
      expect(
        copiedMessage.linkPreview!.imageUrl,
        'https://newwebsite.com/logo.png',
      );
      expect(copiedMessage.linkPreview!.link, 'https://newwebsite.com');
    });

    test('retains original values when copyWith is called without new values',
        () {
      final copiedMessage = message.copyWith();

      // Assert all properties
      expect(copiedMessage.id, '1');
      expect(copiedMessage.senderId, 'sender1');
      expect(
        copiedMessage.timestamp,
        DateTime.fromMillisecondsSinceEpoch(1621267200000, isUtc: true),
      );
      expect(copiedMessage.text, 'Hello, world!');
      expect(copiedMessage.metadata, {'key': 'value'});
    });

    test('treats objects with the same properties as equal', () {
      final json = {
        'id': '1',
        'senderId': 'sender1',
        'timestamp': 1621267200000, // in milliseconds
        'type': 'text',
        'text': 'Hello, world!',
        'metadata': {'key': 'value'},
        'linkPreview': {
          'title': 'Google',
          'description': 'Google homepage',
          'imageUrl': 'https://google.com/logo.png',
          'link': 'https://google.com',
        },
      };

      final message2 = TextMessage.fromJson(json);

      // Two objects with the same properties should be equal.
      expect(message == message2, true);

      // Change one property of message2.
      final copiedMessage = message2.copyWith(text: 'New text');

      // The original and the changed objects should not be equal.
      expect(message == copiedMessage, false);
    });

    test('treats objects with different ID or timestamp as not equal', () {
      // Create another TextMessage with a different ID
      final jsonDifferentId = {
        'id': '2',
        'senderId': 'sender1',
        'timestamp': 1621267200000, // in milliseconds
        'type': 'text',
        'text': 'Hello, world!',
        'metadata': {'key': 'value'},
      };

      final messageDifferentId = TextMessage.fromJson(jsonDifferentId);

      // Should not be equal
      expect(message == messageDifferentId, false);

      // Create another TextMessage with a different timestamp
      final jsonDifferentTimestamp = {
        'id': '1',
        'senderId': 'sender1',
        'timestamp': 1621267200000 + 10000, // in milliseconds
        'type': 'text',
        'text': 'Hello, world!',
        'metadata': {'key': 'value'},
      };

      final messageDifferentTimestamp =
          TextMessage.fromJson(jsonDifferentTimestamp);

      // Should not be equal
      expect(message == messageDifferentTimestamp, false);
    });
  });
}
