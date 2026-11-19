import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter_test/flutter_test.dart';

String? _firstLink(String text) => RegExp(
  regexLink,
  caseSensitive: false,
  unicode: true,
).firstMatch(text)?.group(0);

void main() {
  group('regexLink', () {
    test('matches a simple link', () {
      expect(_firstLink('Visit https://flyer.chat'), 'https://flyer.chat');
    });

    test('keeps underscores in the path and query', () {
      expect(
        _firstLink(
          'https://www.youtube.com/live/wFTD_Tm9als?si=w99NseYI2KIDz7_Z',
        ),
        'https://www.youtube.com/live/wFTD_Tm9als?si=w99NseYI2KIDz7_Z',
      );
      expect(
        _firstLink('Docs: https://example.com/some_path/file_name?key=a_b'),
        'https://example.com/some_path/file_name?key=a_b',
      );
    });

    test('keeps underscores in links without a scheme', () {
      expect(_firstLink('see example.com/a_b/c'), 'example.com/a_b/c');
    });

    test('does not include a trailing period', () {
      expect(
        _firstLink('See https://example.com/x_y.'),
        'https://example.com/x_y',
      );
      expect(
        _firstLink('See https://example.com/x_y. Thanks'),
        'https://example.com/x_y',
      );
    });
  });
}
