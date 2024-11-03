import 'dart:typed_data';

abstract class BaseCache {
  Future<void> set(String key, Uint8List value);
  Future<Uint8List> get(String key);
  Future<bool> contains(String key);
  Future<void> delete(String key);
  Future<void> updateKey(String key, String newKey);

  void dispose();
}
