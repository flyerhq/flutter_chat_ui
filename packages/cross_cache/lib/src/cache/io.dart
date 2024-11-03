import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';

import 'base_cache.dart';

class Cache extends BaseCache {
  @override
  Future<void> set(String key, Uint8List value) async {
    final cache = await getApplicationCacheDirectory();
    final cacheDirectory = Directory('${cache.path}/cross_cache');

    if (!await cacheDirectory.exists()) {
      await cacheDirectory.create(recursive: true);
    }

    final filePathBytes = utf8.encode(key);
    final filePath = sha256.convert(filePathBytes).toString();

    final path = '${cacheDirectory.path}/$filePath';
    final file = File(path);
    await file.writeAsBytes(value);
  }

  @override
  Future<Uint8List> get(String key) async {
    final cache = await getApplicationCacheDirectory();
    final filePathBytes = utf8.encode(key);
    final filePath = sha256.convert(filePathBytes).toString();
    final file = File('${cache.path}/cross_cache/$filePath');

    if (await file.exists()) {
      return await file.readAsBytes();
    } else {
      throw FileSystemException('File not found', file.path);
    }
  }

  @override
  Future<bool> contains(String key) async {
    final cache = await getApplicationCacheDirectory();
    final filePathBytes = utf8.encode(key);
    final filePath = sha256.convert(filePathBytes).toString();
    final file = File('${cache.path}/cross_cache/$filePath');

    return file.exists();
  }

  @override
  Future<void> delete(String key) async {
    final cache = await getApplicationCacheDirectory();
    final filePathBytes = utf8.encode(key);
    final filePath = sha256.convert(filePathBytes).toString();
    final file = File('${cache.path}/cross_cache/$filePath');

    if (await file.exists()) {
      await file.delete();
    }
  }

  @override
  Future<void> updateKey(String key, String newKey) async {
    final cache = await getApplicationCacheDirectory();
    final filePathBytes = utf8.encode(key);
    final filePath = sha256.convert(filePathBytes).toString();
    final file = File('${cache.path}/cross_cache/$filePath');

    if (await file.exists()) {
      final newFilePathBytes = utf8.encode(newKey);
      final newFilePath = sha256.convert(newFilePathBytes).toString();
      final newFile = File('${cache.path}/cross_cache/$newFilePath');

      await file.rename(newFile.path);
    } else {
      throw FileSystemException('File not found', file.path);
    }
  }

  @override
  void dispose() {}
}
