import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Message', () {
    test('returns correct message type from JSON', () {
      // Test ImageMessage
      final imageMessageJson = {
        'id': '1',
        'senderId': 'sender1',
        'timestamp': 1621267200000, // in milliseconds
        'type': 'image',
        'source': 'https://example.com/image.png',
        'metadata': {'key': 'value'},
      };
      var message = Message.fromJson(imageMessageJson);
      expect(message, isA<ImageMessage>());

      // Test TextMessage
      final textMessageJson = {
        'id': '2',
        'senderId': 'sender1',
        'timestamp': 1621267200000, // in milliseconds
        'type': 'text',
        'text': 'Hello',
        'metadata': {'key': 'value'},
      };
      message = Message.fromJson(textMessageJson);
      expect(message, isA<TextMessage>());

      // Test UnsupportedMessage
      final unsupportedMessageJson = {
        'id': '3',
        'senderId': 'sender1',
        'timestamp': 1621267200000, // in milliseconds
        'type': 'unsupported',
        'metadata': {'key': 'value'},
      };
      message = Message.fromJson(unsupportedMessageJson);
      expect(message, isA<UnsupportedMessage>());

      // Test for a message type that doesn't exist
      final unsupportedTypeJson = {
        'id': '4',
        'senderId': 'sender1',
        'timestamp': 1621267200000, // in milliseconds
        'type': 'nonexistentType',
        'metadata': {'key': 'value'},
      };
      message = Message.fromJson(unsupportedTypeJson);
      expect(message, isA<UnsupportedMessage>());
    });
  });
}
