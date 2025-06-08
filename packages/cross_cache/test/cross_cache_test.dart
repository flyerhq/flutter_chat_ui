import 'dart:io';

import 'package:cross_cache/cross_cache.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'transparent_image.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Mock the path_provider platform channel
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
        const MethodChannel('plugins.flutter.io/path_provider'),
        (MethodCall methodCall) async {
          if (methodCall.method == 'getApplicationCacheDirectory') {
            return Directory.systemTemp.path;
          }
          return null;
        },
      );

  group('CrossCache', () {
    const path = 'https://example.com/image.png';

    late Dio dio;
    late CrossCache crossCache;
    late DioAdapter dioAdapter;

    setUp(() async {
      dio = Dio(BaseOptions(headers: {'user-agent': 'test'}));
      crossCache = CrossCache(dio: dio);
      dioAdapter = DioAdapter(dio: dio);

      // Clear the cache directory to ensure clean state
      final cacheDir = Directory('${Directory.systemTemp.path}/cross_cache');
      if (await cacheDir.exists()) {
        await cacheDir.delete(recursive: true);
      }
    });

    tearDown(() {
      crossCache.dispose();
    });

    tearDownAll(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            const MethodChannel('plugins.flutter.io/path_provider'),
            null,
          );
    });

    test('downloads data using provided headers', () async {
      var requestCount = 0;
      dioAdapter.onGet(path, (server) {
        requestCount++;
        server.reply(200, transparentImage);
      }, headers: {'Authorization': 'Bearer token123'});

      // Test that CrossCache passes custom headers to the network request
      final customHeaders = {'Authorization': 'Bearer token123'};
      final bytes = await crossCache.downloadAndSave(
        path,
        headers: customHeaders,
      );

      expect(requestCount, 1);
      expect(bytes, transparentImage);
    });

    test('caches data correctly', () async {
      var hitCount = 0;
      dioAdapter.onGet(path, (server) {
        hitCount++;
        server.reply(200, transparentImage);
      });

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
