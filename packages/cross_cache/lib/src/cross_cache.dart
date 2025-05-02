import 'dart:convert' show base64Decode;

import 'package:cross_file/cross_file.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle, Uint8List;

import 'cache/cache.dart'
    if (dart.library.io) 'cache/io.dart'
    if (dart.library.html) 'cache/html.dart';

/// A cross-platform caching utility for downloading and storing binary data (like images).
///
/// It supports various data sources:
/// - HTTP/HTTPS URLs
/// - Local file paths
/// - Flutter asset paths (`assets/...`)
/// - Data URIs (`data:...`)
/// - Base64 encoded strings
///
/// Uses a platform-specific [Cache] implementation ([io.dart] or [html.dart])
/// for persistence and [Dio] for network requests.
class CrossCache {
  final Cache _cache;
  final Dio _dio;

  /// Optional base options for the internal [Dio] instance if one is not provided.
  final BaseOptions? options;

  /// Creates a [CrossCache] instance.
  ///
  /// Takes an optional [Dio] instance. If not provided, a default one is created
  /// using the optional [options].
  CrossCache({Dio? dio, this.options})
    : _cache = Cache(),
      _dio = dio ?? Dio(options);

  /// Downloads data from the given [source] and saves it to the cache.
  ///
  /// If the data is already cached, it returns the cached bytes directly.
  /// Otherwise, it determines the source type (network, asset, local file, data URI, base64)
  /// fetches the data, saves it to the cache using the [source] string as the key,
  /// and returns the downloaded bytes.
  ///
  /// - [source]: The URL, file path, asset path, data URI, or base64 string.
  /// - [headers]: Optional HTTP headers for network requests.
  /// - [onReceiveProgress]: Optional callback for tracking download progress.
  ///
  /// Throws an exception if the source is invalid or download fails.
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

  /// Stores the given byte [value] in the cache with the specified [key].
  ///
  /// Delegates to the underlying platform-specific [Cache] implementation.
  Future<void> set(String key, Uint8List value) => _cache.set(key, value);

  /// Retrieves the cached byte data for the given [key].
  ///
  /// Delegates to the underlying platform-specific [Cache] implementation.
  /// Throws if the key is not found.
  Future<Uint8List> get(String key) => _cache.get(key);

  /// Checks if the cache contains an entry for the given [key].
  ///
  /// Delegates to the underlying platform-specific [Cache] implementation.
  Future<bool> contains(String key) => _cache.contains(key);

  /// Removes the cache entry for the given [key].
  ///
  /// Delegates to the underlying platform-specific [Cache] implementation.
  Future<void> delete(String key) => _cache.delete(key);

  /// Renames a cache entry from [key] to [newKey].
  ///
  /// Delegates to the underlying platform-specific [Cache] implementation.
  /// Throws if the original [key] is not found.
  Future<void> updateKey(String key, String newKey) =>
      _cache.updateKey(key, newKey);

  /// Disposes resources used by the cache.
  ///
  /// Closes the internal [Dio] client and calls `dispose` on the underlying
  /// platform-specific [Cache] implementation.
  void dispose() {
    _dio.close(force: true);
    _cache.dispose();
  }
}
