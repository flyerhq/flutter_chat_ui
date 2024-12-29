import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isOnlyEmoji', () {
    test('returns false for empty string', () {
      expect(isOnlyEmoji(''), isFalse);
    });

    test('returns false for whitespace only', () {
      expect(isOnlyEmoji('   '), isFalse);
    });

    test('returns true for single emoji', () {
      expect(isOnlyEmoji('👍'), isTrue);
    });

    test('returns true for multiple emojis', () {
      expect(isOnlyEmoji('😀😃😄'), isTrue);
    });

    test('returns true for emojis with whitespace', () {
      expect(isOnlyEmoji('👋 😎 🎉'), isTrue);
    });

    test('returns false for text with emojis', () {
      expect(isOnlyEmoji('Hello 👋'), isFalse);
    });

    test('returns false for text only', () {
      expect(isOnlyEmoji('Hello world'), isFalse);
    });

    test('returns true for complex emojis', () {
      expect(isOnlyEmoji('👨‍👩‍👧‍👦'), isTrue);
    });

    test('returns true for emoji with modifiers', () {
      expect(isOnlyEmoji('👍🏻'), isTrue);
    });

    test('returns false for numbers', () {
      expect(isOnlyEmoji('123'), isFalse);
    });

    test('returns false for special characters', () {
      expect(isOnlyEmoji('!@#\$%'), isFalse);
    });

    test('returns true for multiline emojis', () {
      expect(isOnlyEmoji('😀\n😃\n😄'), isTrue);
    });

    test('returns true for multiline emojis with spaces', () {
      expect(isOnlyEmoji('👋 😎\n🎉 ✨'), isTrue);
    });

    test('returns false for multiline text with emojis', () {
      expect(isOnlyEmoji('Hello 👋\nWorld 😊'), isFalse);
    });
  });
}
