import 'package:cross_cache/cross_cache.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'transparent_image.dart';

void main() {
  group('CrossCache', () {
    final dio = Dio(BaseOptions(headers: {'user-agent': 'test'}));
    const path = 'https://example.com/image.png';

    late CrossCache crossCache;
    late DioAdapter dioAdapter;

    setUp(() {
      crossCache = CrossCache(dio: dio);
      dioAdapter = DioAdapter(dio: dio);
    });

    test('treats objects with the same properties as equal', () async {
      dioAdapter.onGet(
        path,
        (server) => server.reply(
          200,
          transparentImage,
          delay: const Duration(seconds: 1),
        ),
      );

      final response = await dio.get(
        path,
        options: Options(
          headers: {'keep-alive': 1},
          responseType: ResponseType.bytes,
        ),
      );

      expect(
        response.requestOptions.headers,
        {'user-agent': 'test', 'keep-alive': 1},
      );

      final url = await crossCache.downloadAndSave(path);

      expect(url, path);
    });
  });
}
