import 'dart:typed_data';

import 'base_cache.dart';

class Cache extends BaseCache {
  @override
  Future<void> set(String key, Uint8List value) {
    throw UnimplementedError(
      'Cache is not available in your current platform.',
    );
  }

  @override
  Future<Uint8List> get(String key) {
    throw UnimplementedError(
      'Cache is not available in your current platform.',
    );
  }

  @override
  Future<bool> contains(String key) {
    throw UnimplementedError(
      'Cache is not available in your current platform.',
    );
  }

  @override
  Future<void> delete(String key) {
    throw UnimplementedError(
      'Cache is not available in your current platform.',
    );
  }

  @override
  Future<void> updateKey(String key, String newKey) {
    throw UnimplementedError(
      'Cache is not available in your current platform.',
    );
  }

  @override
  void dispose() {
    throw UnimplementedError(
      'Cache is not available in your current platform.',
    );
  }
}
