import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LinkPreview', () {
    late LinkPreview linkPreview;

    setUp(() {
      final json = {
        'link': 'https://google.com',
        'description': 'Google homepage',
        'imageUrl': 'https://google.com/logo.png',
        'title': 'Google',
      };

      linkPreview = LinkPreview.fromJson(json);
    });

    test('treats objects with the same properties as equal', () {
      final json = {
        'link': 'https://google.com',
        'description': 'Google homepage',
        'imageUrl': 'https://google.com/logo.png',
        'title': 'Google',
      };

      final linkPreview2 = LinkPreview.fromJson(json);

      // Two objects with the same properties should be equal.
      expect(linkPreview == linkPreview2, true);

      // Change one property of linkPreview2.
      final copiedLinkPreview = linkPreview2.copyWith(
        title: null,
      );

      // The original and the changed objects should not be equal.
      expect(linkPreview == copiedLinkPreview, false);
    });
  });
}
