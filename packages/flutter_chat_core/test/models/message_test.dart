import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Message', () {
    test('returns correct message type from JSON', () {
      // Test ImageMessage
      final imageMessageJson = {
        'id': '1',
        'authorId': 'me',
        'createdAt': 1736893310000, // in milliseconds
        'type': 'image',
        'source': 'https://example.com/image.png',
        'metadata': {'key': 'value'},
      };
      var message = Message.fromJson(imageMessageJson);
      expect(message, isA<ImageMessage>());

      // Test TextMessage
      final textMessageJson = {
        'id': '2',
        'authorId': 'me',
        'createdAt': 1736893310000, // in milliseconds
        'type': 'text',
        'text': 'Hello',
        'metadata': {'key': 'value'},
      };
      message = Message.fromJson(textMessageJson);
      expect(message, isA<TextMessage>());

      // Test UnsupportedMessage
      final unsupportedMessageJson = {
        'id': '3',
        'authorId': 'me',
        'createdAt': 1736893310000, // in milliseconds
        'type': 'unsupported',
        'metadata': {'key': 'value'},
      };
      message = Message.fromJson(unsupportedMessageJson);
      expect(message, isA<UnsupportedMessage>());

      // Test for a message type that doesn't exist
      final unsupportedTypeJson = {
        'id': '4',
        'authorId': 'me',
        'createdAt': 1736893310000, // in milliseconds
        'type': 'nonexistentType',
        'metadata': {'key': 'value'},
      };
      message = Message.fromJson(unsupportedTypeJson);
      expect(message, isA<UnsupportedMessage>());
    });
  });

  group('TextMessage', () {
    late TextMessage message;

    setUp(() {
      final json = {
        'id': '1',
        'authorId': 'me',
        'createdAt': 1736893310000, // in milliseconds
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
      expect(message.authorId, 'me');
      expect(
        message.createdAt,
        DateTime.fromMillisecondsSinceEpoch(1736893310000, isUtc: true),
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
        'authorId': 'me',
        'createdAt': 1736893310000,
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
        createdAt: DateTime.fromMillisecondsSinceEpoch(
          1736893310000 + 1000,
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
      expect(copiedMessage.authorId, 'me');
      expect(
        copiedMessage.createdAt,
        DateTime.fromMillisecondsSinceEpoch(1736893310000 + 1000, isUtc: true),
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

    test(
      'retains original values when copyWith is called without new values',
      () {
        final copiedMessage = message.copyWith();

        // Assert all properties
        expect(copiedMessage.id, '1');
        expect(copiedMessage.authorId, 'me');
        expect(
          copiedMessage.createdAt,
          DateTime.fromMillisecondsSinceEpoch(1736893310000, isUtc: true),
        );
        expect(copiedMessage.text, 'Hello, world!');
        expect(copiedMessage.metadata, {'key': 'value'});
      },
    );

    test('treats objects with the same properties as equal', () {
      final json = {
        'id': '1',
        'authorId': 'me',
        'createdAt': 1736893310000, // in milliseconds
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
        'authorId': 'me',
        'createdAt': 1736893310000, // in milliseconds
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
        'authorId': 'me',
        'createdAt': 1736893310000 + 1000, // in milliseconds
        'type': 'text',
        'text': 'Hello, world!',
        'metadata': {'key': 'value'},
      };

      final messageDifferentTimestamp = TextMessage.fromJson(
        jsonDifferentTimestamp,
      );

      // Should not be equal
      expect(message == messageDifferentTimestamp, false);
    });
  });

  group('ImageMessage', () {
    late ImageMessage message;

    setUp(() {
      final json = {
        'id': '1',
        'authorId': 'me',
        'createdAt': 1736893310000, // in milliseconds
        'type': 'image',
        'source': 'https://example.com/image.jpg',
        'metadata': {'key': 'value'},
      };

      message = ImageMessage.fromJson(json);
    });

    test('initializes correctly from a JSON', () {
      expect(message.id, '1');
      expect(message.authorId, 'me');
      expect(
        message.createdAt,
        DateTime.fromMillisecondsSinceEpoch(1736893310000, isUtc: true),
      );
      expect(message.source, 'https://example.com/image.jpg');
      expect(message.metadata, {'key': 'value'});
    });

    test('converts correctly to a JSON', () {
      expect(message.toJson(), {
        'id': '1',
        'authorId': 'me',
        'createdAt': 1736893310000,
        'type': 'image',
        'source': 'https://example.com/image.jpg',
        'metadata': {'key': 'value'},
      });
    });

    test('JSON serialization is symmetrical', () {
      final messageJson = message.toJson();
      final messageFromJson = ImageMessage.fromJson(messageJson);
      expect(messageFromJson.toJson(), messageJson);
    });

    test('creates a correct copy with new values through copyWith', () {
      final copiedMessage = message.copyWith(
        createdAt: DateTime.fromMillisecondsSinceEpoch(
          1736893310000 + 1000,
          isUtc: true,
        ),
        metadata: {'key': 'newValue'},
        source: 'https://example.com/image2.jpg',
      );

      // Assert all properties
      expect(copiedMessage.id, '1');
      expect(copiedMessage.authorId, 'me');
      expect(
        copiedMessage.createdAt,
        DateTime.fromMillisecondsSinceEpoch(1736893310000 + 1000, isUtc: true),
      );
      expect(copiedMessage.source, 'https://example.com/image2.jpg');
      expect(copiedMessage.metadata, {'key': 'newValue'});
    });

    test(
      'retains original values when copyWith is called without new values',
      () {
        final copiedMessage = message.copyWith();

        // Assert all properties
        expect(copiedMessage.id, '1');
        expect(copiedMessage.authorId, 'me');
        expect(
          copiedMessage.createdAt,
          DateTime.fromMillisecondsSinceEpoch(1736893310000, isUtc: true),
        );
        expect(copiedMessage.source, 'https://example.com/image.jpg');
        expect(copiedMessage.metadata, {'key': 'value'});
      },
    );

    test('treats objects with the same properties as equal', () {
      final json = {
        'id': '1',
        'authorId': 'me',
        'createdAt': 1736893310000, // in milliseconds
        'type': 'image',
        'source': 'https://example.com/image.jpg',
        'metadata': {'key': 'value'},
      };

      final message2 = ImageMessage.fromJson(json);

      // Two objects with the same properties should be equal.
      expect(message == message2, true);

      // Change one property of message2.
      final copiedMessage = message2.copyWith(
        source: 'https://example.com/image2.jpg',
      );

      // The original and the changed objects should not be equal.
      expect(message == copiedMessage, false);
    });

    test('treats objects with different ID or timestamp as not equal', () {
      // Create another ImageMessage with a different ID
      final jsonDifferentId = {
        'id': '2',
        'authorId': 'me',
        'createdAt': 1736893310000, // in milliseconds
        'type': 'image',
        'source': 'https://example.com/image.jpg',
        'metadata': {'key': 'value'},
      };

      final messageDifferentId = ImageMessage.fromJson(jsonDifferentId);

      // Should not be equal
      expect(message == messageDifferentId, false);

      // Create another ImageMessage with a different timestamp
      final jsonDifferentTimestamp = {
        'id': '1',
        'authorId': 'me',
        'createdAt': 1736893310000 + 1000, // in milliseconds
        'type': 'image',
        'source': 'https://example.com/image.jpg',
        'metadata': {'key': 'value'},
      };

      final messageDifferentTimestamp = ImageMessage.fromJson(
        jsonDifferentTimestamp,
      );

      // Should not be equal
      expect(message == messageDifferentTimestamp, false);
    });
  });

  group('UnsupportedMessage', () {
    late UnsupportedMessage message;

    setUp(() {
      final json = {
        'id': '1',
        'authorId': 'me',
        'createdAt': 1736893310000, // in milliseconds
        'type': 'unsupported',
        'metadata': {'key': 'value'},
      };

      message = UnsupportedMessage.fromJson(json);
    });

    test('initializes correctly from a JSON', () {
      expect(message.id, '1');
      expect(message.authorId, 'me');
      expect(
        message.createdAt,
        DateTime.fromMillisecondsSinceEpoch(1736893310000, isUtc: true),
      );
      expect(message.metadata, {'key': 'value'});
    });

    test('converts correctly to a JSON', () {
      expect(message.toJson(), {
        'id': '1',
        'authorId': 'me',
        'createdAt': 1736893310000,
        'type': 'unsupported',
        'metadata': {'key': 'value'},
      });
    });

    test('JSON serialization is symmetrical', () {
      final messageJson = message.toJson();
      final messageFromJson = UnsupportedMessage.fromJson(messageJson);
      expect(messageFromJson.toJson(), messageJson);
    });

    test('creates a correct copy with new values through copyWith', () {
      final copiedMessage = message.copyWith(
        createdAt: DateTime.fromMillisecondsSinceEpoch(
          1736893310000 + 1000,
          isUtc: true,
        ),
        metadata: {'key': 'newValue'},
      );

      // Assert all properties
      expect(copiedMessage.id, '1');
      expect(copiedMessage.authorId, 'me');
      expect(
        copiedMessage.createdAt,
        DateTime.fromMillisecondsSinceEpoch(1736893310000 + 1000, isUtc: true),
      );
      expect(copiedMessage.metadata, {'key': 'newValue'});
    });

    test(
      'retains original values when copyWith is called without new values',
      () {
        final copiedMessage = message.copyWith();

        // Assert all properties
        expect(copiedMessage.id, '1');
        expect(copiedMessage.authorId, 'me');
        expect(
          copiedMessage.createdAt,
          DateTime.fromMillisecondsSinceEpoch(1736893310000, isUtc: true),
        );
        expect(copiedMessage.metadata, {'key': 'value'});
      },
    );

    test('treats objects with the same properties as equal', () {
      final json = {
        'id': '1',
        'authorId': 'me',
        'createdAt': 1736893310000, // in milliseconds
        'type': 'unsupported',
        'metadata': {'key': 'value'},
      };

      final message2 = UnsupportedMessage.fromJson(json);

      // Two objects with the same properties should be equal.
      expect(message == message2, true);

      // Change one property of message2.
      final copiedMessage = message2.copyWith(
        createdAt: DateTime.fromMillisecondsSinceEpoch(
          1736893310000 + 1000,
          isUtc: true,
        ),
      );

      // The original and the changed objects should not be equal.
      expect(message == copiedMessage, false);
    });

    test('treats objects with different ID or timestamp as not equal', () {
      // Create another UnsupportedMessage with a different ID
      final jsonDifferentId = {
        'id': '2',
        'authorId': 'me',
        'createdAt': 1736893310000, // in milliseconds
        'type': 'unsupported',
        'metadata': {'key': 'value'},
      };

      final messageDifferentId = UnsupportedMessage.fromJson(jsonDifferentId);

      // Should not be equal
      expect(message == messageDifferentId, false);

      // Create another UnsupportedMessage with a different timestamp
      final jsonDifferentTimestamp = {
        'id': '1',
        'authorId': 'me',
        'createdAt': 1736893310000 + 1000, // in milliseconds
        'type': 'unsupported',
        'metadata': {'key': 'value'},
      };

      final messageDifferentTimestamp = UnsupportedMessage.fromJson(
        jsonDifferentTimestamp,
      );

      // Should not be equal
      expect(message == messageDifferentTimestamp, false);
    });
  });
}
