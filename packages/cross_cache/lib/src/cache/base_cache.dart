import 'dart:typed_data';

/// Abstract base class defining the interface for a platform-specific cache.
///
/// Implementations handle the actual storage mechanism (e.g., file system, IndexedDB).
abstract class BaseCache {
  /// Stores the given [value] associated with the [key].
  ///
  /// If the key already exists, its value is overwritten.
  Future<void> set(String key, Uint8List value);

  /// Retrieves the value associated with the [key].
  ///
  /// Throws an exception if the key is not found.
  Future<Uint8List> get(String key);

  /// Checks if the cache contains an entry for the given [key].
  Future<bool> contains(String key);

  /// Removes the entry associated with the [key] from the cache.
  ///
  /// Does nothing if the key is not found.
  Future<void> delete(String key);

  /// Renames an existing cache entry from [key] to [newKey].
  ///
  /// Throws an exception if the original [key] is not found.
  Future<void> updateKey(String key, String newKey);

  /// Releases any resources held by the cache instance.
  ///
  /// For example, closes database connections.
  void dispose();
}
