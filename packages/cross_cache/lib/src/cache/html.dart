import 'dart:async';
import 'dart:typed_data';
import 'package:idb_shim/idb_browser.dart';

import 'base_cache.dart';

/// Web (HTML) implementation of [BaseCache] using IndexedDB.
class Cache extends BaseCache {
  Database? _db;
  Completer<void>? _dbOpenCompleter;

  /// Initializes the IndexedDB database connection.
  Cache() {
    _open();
  }

  Future<void> _onUpgradeNeeded(VersionChangeEvent event) async {
    _db = event.database;
    if (!_db!.objectStoreNames.contains('data')) {
      _db!.createObjectStore('data');
    }
  }

  Future<void> _open() async {
    if (_dbOpenCompleter != null) {
      return _dbOpenCompleter!.future;
    }

    _dbOpenCompleter = Completer<void>();

    try {
      _db = await idbFactoryBrowser.open(
        'cross_cache_db',
        version: 1,
        onUpgradeNeeded: _onUpgradeNeeded,
      );

      _dbOpenCompleter?.complete();
    } catch (e) {
      _dbOpenCompleter?.completeError(e);
      _db = null;
    } finally {
      _dbOpenCompleter = null;
    }
  }

  Future<void> _ensureDbOpen() async {
    if (_db == null) {
      if (_dbOpenCompleter != null) {
        await _dbOpenCompleter!.future;
      } else {
        await _open();
      }

      if (_db == null) {
        throw Exception('IndexedDB is not supported or failed to open.');
      }
    }
  }

  @override
  Future<void> set(String key, Uint8List value) async {
    await _ensureDbOpen();

    final transaction = _db!.transaction('data', 'readwrite');
    final store = transaction.objectStore('data');
    await store.put(value, key);
    await transaction.completed;
  }

  @override
  Future<Uint8List> get(String key) async {
    await _ensureDbOpen();

    final transaction = _db!.transaction('data', 'readonly');
    final store = transaction.objectStore('data');
    final data = await store.getObject(key);
    await transaction.completed;

    if (data is Uint8List) {
      return data;
    } else if (data == null) {
      throw Exception('Key not found in cache: $key');
    } else {
      throw Exception('Data is not of type Uint8List');
    }
  }

  @override
  Future<bool> contains(String key) async {
    await _ensureDbOpen();

    final transaction = _db!.transaction('data', 'readonly');
    final store = transaction.objectStore('data');
    final result = await store.getObject(key);
    await transaction.completed;

    return result != null;
  }

  @override
  Future<void> delete(String key) async {
    await _ensureDbOpen();

    final transaction = _db!.transaction('data', 'readwrite');
    final store = transaction.objectStore('data');
    await store.delete(key);
    await transaction.completed;
  }

  @override
  Future<void> updateKey(String key, String newKey) async {
    await _ensureDbOpen();

    final transaction = _db!.transaction('data', 'readwrite');
    final store = transaction.objectStore('data');
    final data = await store.getObject(key);

    if (data == null) {
      await transaction.completed;
      throw Exception('Key not found: $key');
    }

    try {
      await store.put(data, newKey);
      await store.delete(key);
      await transaction.completed;
    } catch (e) {
      transaction.abort();
      rethrow;
    }
  }

  @override
  void dispose() {
    _db?.close();
    _db = null;
    if (_dbOpenCompleter != null && !_dbOpenCompleter!.isCompleted) {
      _dbOpenCompleter!.completeError(Exception('Cache disposed during open'));
      _dbOpenCompleter = null;
    }
  }
}
