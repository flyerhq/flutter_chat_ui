import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LinkPreviewData', () {
    late LinkPreviewData linkPreviewData;

    setUp(() {
      final json = {
        'link': 'https://google.com',
        'description': 'Google homepage',
        'imageUrl': 'https://google.com/logo.png',
        'title': 'Google',
      };

      linkPreviewData = LinkPreviewData.fromJson(json);
    });

    test('treats objects with the same properties as equal', () {
      final json = {
        'link': 'https://google.com',
        'description': 'Google homepage',
        'imageUrl': 'https://google.com/logo.png',
        'title': 'Google',
      };

      final linkPreviewData2 = LinkPreviewData.fromJson(json);

      // Two objects with the same properties should be equal.
      expect(linkPreviewData == linkPreviewData2, true);

      // Change one property of linkPreviewData2.
      final copiedLinkPreview = linkPreviewData2.copyWith(title: null);

      // The original and the changed objects should not be equal.
      expect(linkPreviewData == copiedLinkPreview, false);
    });
  });
}
