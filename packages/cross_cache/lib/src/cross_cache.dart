import 'dart:convert' show base64Decode;

import 'package:cross_file/cross_file.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle, Uint8List;

import 'cache/cache.dart'
    if (dart.library.io) 'cache/io.dart'
    if (dart.library.html) 'cache/html.dart';

class CrossCache {
  final Cache _cache;
  final Dio _dio;
  final BaseOptions? options;

  CrossCache({Dio? dio, this.options})
      : _cache = Cache(),
        _dio = dio ?? Dio(options);

  Future<Uint8List> downloadAndSave(
    String source, {
    Map<String, dynamic>? headers,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final cached = await _cache.get(source);
      return cached;
      // ignore: empty_catches
    } catch (e) {}

    final uri = Uri.tryParse(source);

    if (source.startsWith('assets/')) {
      final byteData = await rootBundle.load(source);
      final bytes = Uint8List.view(byteData.buffer);
      await _cache.set(source, bytes);
      return bytes;
    } else if (uri != null && uri.scheme == 'data') {
      final data = uri.data;
      if (data == null) {
        throw Exception('Invalid data URI');
      }
      final bytes = data.contentAsBytes();
      await _cache.set(source, bytes);
      return bytes;
    } else if (uri != null &&
        (uri.scheme == 'http' ||
            uri.scheme == 'https' ||
            uri.scheme == 'blob')) {
      final response = await _dio.get(
        source,
        options: Options(headers: headers, responseType: ResponseType.bytes),
        onReceiveProgress: onReceiveProgress,
      );

      if (response.statusCode != 200) {
        throw DioException.badResponse(
          statusCode: response.statusCode ?? -1,
          requestOptions: response.requestOptions,
          response: response,
        );
      }

      final bytes = response.data as Uint8List;
      await _cache.set(source, bytes);

      return bytes;
    } else {
      try {
        final xfile = XFile(source);
        final bytes = await xfile.readAsBytes();
        await _cache.set(source, bytes);
        return bytes;
        // ignore: empty_catches
      } catch (e) {}

      try {
        final bytes = base64Decode(source);
        await _cache.set(source, bytes);
        return bytes;
        // ignore: empty_catches
      } catch (e) {}

      throw Exception('Invalid source: cannot be processed');
    }
  }

  Future<void> set(String key, Uint8List value) => _cache.set(key, value);

  Future<Uint8List> get(String key) => _cache.get(key);

  Future<bool> contains(String key) => _cache.contains(key);

  Future<void> delete(String key) => _cache.delete(key);

  Future<void> updateKey(String key, String newKey) =>
      _cache.updateKey(key, newKey);

  void dispose() {
    _dio.close(force: true);
    _cache.dispose();
  }
}
