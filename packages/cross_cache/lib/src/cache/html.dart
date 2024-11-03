import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
// ignore: uri_does_not_exist
import 'dart:indexed_db';
import 'dart:typed_data';

import 'base_cache.dart';

class Cache extends BaseCache {
  // ignore: undefined_class
  Database? _db;
  Completer<void>? _dbOpenCompleter;

  Cache() {
    _open();
  }

  // ignore: undefined_class
  Future<void> _onUpgradeNeeded(VersionChangeEvent event) async {
    _db = event.target.result;
    _db?.createObjectStore('data');
  }

  Future<void> _open() async {
    // ignore: undefined_identifier
    if (!IdbFactory.supported || _dbOpenCompleter != null) {
      return;
    }

    _dbOpenCompleter = Completer<void>();

    try {
      _db = await window.indexedDB!.open(
        'cross_cache_db',
        version: 1,
        onUpgradeNeeded: _onUpgradeNeeded,
      );

      _dbOpenCompleter?.complete();
    } catch (e) {
      _dbOpenCompleter?.completeError(e);
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
    }
  }

  @override
  Future<void> set(String key, Uint8List value) async {
    await _ensureDbOpen();

    if (_db == null) {
      throw Exception('IndexedDB is not supported or database failed to open');
    }

    final transaction = _db!.transaction('data', 'readwrite');
    final store = transaction.objectStore('data');
    await store.put(value, key);
    await transaction.completed;
  }

  @override
  Future<Uint8List> get(String key) async {
    await _ensureDbOpen();

    if (_db == null) {
      throw Exception('IndexedDB is not supported or database failed to open');
    }

    final transaction = _db!.transaction('data', 'readonly');
    final store = transaction.objectStore('data');
    final data = await store.getObject(key);
    await transaction.completed;

    if (data is Uint8List) {
      return data;
    } else {
      throw Exception('Data is not of type Uint8List');
    }
  }

  @override
  Future<bool> contains(String key) async {
    await _ensureDbOpen();

    if (_db == null) {
      throw Exception('IndexedDB is not supported or database failed to open');
    }

    final transaction = _db!.transaction('data', 'readonly');
    final store = transaction.objectStore('data');
    final request = store.getKey(key);
    final result = await _completeRequest(request);
    await transaction.completed;

    return result != null;
  }

  @override
  Future<void> delete(String key) async {
    await _ensureDbOpen();

    if (_db == null) {
      throw Exception('IndexedDB is not supported or database failed to open');
    }

    final transaction = _db!.transaction('data', 'readwrite');
    final store = transaction.objectStore('data');
    await store.delete(key);
    await transaction.completed;
  }

  @override
  Future<void> updateKey(String key, String newKey) async {
    await _ensureDbOpen();

    if (_db == null) {
      throw Exception('IndexedDB is not supported or database failed to open');
    }

    final transaction = _db!.transaction('data', 'readwrite');
    final store = transaction.objectStore('data');
    final data = await store.getObject(key);

    if (data == null) {
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

  // ignore: undefined_class
  Future _completeRequest(Request request) {
    final completer = Completer.sync();
    request.onSuccess.listen((e) {
      completer.complete(request.result);
    });
    request.onError.listen((e) {
      completer.completeError(e);
    });
    return completer.future;
  }

  @override
  void dispose() {
    _db?.close();
    _db = null;
  }
}
