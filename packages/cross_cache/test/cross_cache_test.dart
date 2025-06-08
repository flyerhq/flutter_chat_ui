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

    test('downloads data using provided headers', () async {
      var hitCount = 0;
      dioAdapter.onGet(
        path,
        (server) {
          hitCount++;
          server.reply(
            200,
            transparentImage,
            delay: const Duration(seconds: 1),
          );
        },
      );

      final response = await dio.get(
        path,
        options: Options(
          headers: {'keep-alive': 1},
          responseType: ResponseType.bytes,
        ),
      );

      expect(response.requestOptions.headers, {
        'user-agent': 'test',
        'keep-alive': 1,
      });

      // Reset hit counter to track downloadAndSave calls only.
      hitCount = 0;

      // First download should trigger the network request and cache the result.
      final bytes1 = await crossCache.downloadAndSave(path);

      // Second call with the same path should return cached data without
      // invoking Dio again.
      final bytes2 = await crossCache.downloadAndSave(path);

      expect(hitCount, 1);
      expect(bytes1, transparentImage);
      expect(bytes2, transparentImage);
    });
  });
}
