import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LinkPreviewData', () {
    late LinkPreviewData linkPreviewData;

    setUp(() {
      final json = {
        'link': 'https://google.com',
        'description': 'Google homepage',
        'image': {
          'url': 'https://google.com/logo.png',
          'width': 100.0,
          'height': 100.0,
        },
        'title': 'Google',
      };

      linkPreviewData = LinkPreviewData.fromJson(json);
    });

    test('initializes correctly from a JSON', () {
      expect(linkPreviewData.link, 'https://google.com');
      expect(linkPreviewData.description, 'Google homepage');
      expect(linkPreviewData.image!.url, 'https://google.com/logo.png');
      expect(linkPreviewData.image!.width, 100.0);
      expect(linkPreviewData.image!.height, 100.0);
      expect(linkPreviewData.title, 'Google');
    });

    test('treats objects with the same properties as equal', () {
      final json = {
        'link': 'https://google.com',
        'description': 'Google homepage',
        'image': {
          'url': 'https://google.com/logo.png',
          'width': 100.0,
          'height': 100.0,
        },
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
