import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatBytes', () {
    test('formats bytes correctly when the size is 0', () {
      expect(formatBytes(0), equals('0 B'));
    });

    test('formats bytes correctly', () {
      expect(formatBytes(1024), equals('1.00 kB'));
    });
  });
}
