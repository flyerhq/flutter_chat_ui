import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager {
  static const _key = '***---vocoCustomCacheKey---***';
  static final CustomCacheManager instance = CustomCacheManager._internal();

  factory CustomCacheManager() {
    return instance;
  }

  CustomCacheManager._internal();

  CacheManager get cacheManager => _manager;

  final CacheManager _manager = CacheManager(
    Config(
      _key,
      stalePeriod: const Duration(days: 2),
      maxNrOfCacheObjects: 500,
      repo: JsonCacheInfoRepository(databaseName: _key),
      fileService: HttpFileService(),
    ),
  );
}
