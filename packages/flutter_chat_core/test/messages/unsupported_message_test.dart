import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UnsupportedMessage', () {
    late UnsupportedMessage message;

    setUp(() {
      final json = {
        'id': '1',
        'senderId': 'sender1',
        'timestamp': 1621267200000, // in milliseconds
        'type': 'unsupported',
        'metadata': {'key': 'value'},
      };

      message = UnsupportedMessage.fromJson(json);
    });

    test('initializes correctly from a JSON', () {
      expect(message.id, '1');
      expect(message.senderId, 'sender1');
      expect(
        message.timestamp,
        DateTime.fromMillisecondsSinceEpoch(1621267200000, isUtc: true),
      );
      expect(message.metadata, {'key': 'value'});
    });

    test('converts correctly to a JSON', () {
      expect(message.toJson(), {
        'id': '1',
        'senderId': 'sender1',
        'timestamp': 1621267200000,
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
        timestamp: DateTime.fromMillisecondsSinceEpoch(
          1621267200000 + 10000,
          isUtc: true,
        ),
        metadata: {'key': 'newValue'},
      );

      // Assert all properties
      expect(copiedMessage.id, '1');
      expect(copiedMessage.senderId, 'sender1');
      expect(
        copiedMessage.timestamp,
        DateTime.fromMillisecondsSinceEpoch(1621267200000 + 10000, isUtc: true),
      );
      expect(copiedMessage.metadata, {'key': 'newValue'});
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
      expect(copiedMessage.metadata, {'key': 'value'});
    });

    test('treats objects with the same properties as equal', () {
      final json = {
        'id': '1',
        'senderId': 'sender1',
        'timestamp': 1621267200000, // in milliseconds
        'type': 'unsupported',
        'metadata': {'key': 'value'},
      };

      final message2 = UnsupportedMessage.fromJson(json);

      // Two objects with the same properties should be equal.
      expect(message == message2, true);

      // Change one property of message2.
      final copiedMessage = message2.copyWith(
        timestamp: DateTime.fromMillisecondsSinceEpoch(
          1621267200000 + 10000,
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
        'senderId': 'sender1',
        'timestamp': 1621267200000, // in milliseconds
        'type': 'unsupported',
        'metadata': {'key': 'value'},
      };

      final messageDifferentId = UnsupportedMessage.fromJson(jsonDifferentId);

      // Should not be equal
      expect(message == messageDifferentId, false);

      // Create another UnsupportedMessage with a different timestamp
      final jsonDifferentTimestamp = {
        'id': '1',
        'senderId': 'sender1',
        'timestamp': 1621267200000 + 10000, // in milliseconds
        'type': 'unsupported',
        'metadata': {'key': 'value'},
      };

      final messageDifferentTimestamp =
          UnsupportedMessage.fromJson(jsonDifferentTimestamp);

      // Should not be equal
      expect(message == messageDifferentTimestamp, false);
    });
  });
}
