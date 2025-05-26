import 'package:flutter/foundation.dart';
import '../models/user.dart';
import 'typedefs.dart';

/// A cache for storing resolved users to prevent flickering in recycled widgets.
///
/// Uses a Least Recently Used (LRU) eviction strategy to limit memory usage.
/// When the cache reaches the maximum size, the least recently accessed user
/// will be removed to make space for new entries.
///
/// Extends [ChangeNotifier] to allow widgets to listen for cache modifications.
class UserCache extends ChangeNotifier {
  final Map<UserID, User?> _cache = {};
  final List<UserID> _accessOrder = []; // For LRU eviction

  /// Maximum number of users to keep in the cache.
  final int maxSize;

  /// Creates a user cache with the specified maximum size.
  ///
  /// Example:
  /// ```dart
  /// final cache = UserCache(maxSize: 100);
  /// ```
  UserCache({this.maxSize = 100}) {
    assert(maxSize > 0, 'UserCache maxSize must be a positive integer.');
  }

  /// Gets a user synchronously from cache, or returns null if not cached.
  ///
  /// Updates the LRU access order when a user is found.
  /// Returns null if the user is not in the cache.
  User? getSync(UserID userId) {
    if (_cache.containsKey(userId)) {
      // Update LRU order
      _accessOrder.remove(userId);
      _accessOrder.add(userId);
      return _cache[userId];
    }
    return null;
  }

  /// Gets or resolves a user, updating the cache.
  ///
  /// First checks the cache - if found, returns immediately.
  /// Otherwise, resolves the user using the provided callback,
  /// stores the result in the cache, and returns it.
  Future<User?> getOrResolve(
    UserID userId,
    ResolveUserCallback resolveUser,
  ) async {
    // If in cache, return immediately
    final cachedUser = getSync(userId);
    if (cachedUser != null) {
      return cachedUser;
    }

    // Resolve and update cache
    final user = await resolveUser(userId);
    _cacheUser(userId, user);
    return user;
  }

  /// Manually updates a user in the cache.
  ///
  /// Useful when user data changes and you want to update the cache
  /// without waiting for the next resolution.
  void updateUser(UserID userId, User? user) {
    _cacheUser(userId, user);
  }

  /// Clears the entire cache.
  void clear() {
    _cache.clear();
    _accessOrder.clear();
    notifyListeners();
  }

  /// Removes a specific user from the cache.
  void remove(UserID userId) {
    if (_cache.containsKey(userId)) {
      _cache.remove(userId);
      _accessOrder.remove(userId);
      notifyListeners();
    }
  }

  /// Internal method to add or update a user in the cache.
  /// Handles LRU eviction if the cache is full.
  void _cacheUser(UserID userId, User? user) {
    var needsNotify = true;
    // Handle eviction if needed
    if (_accessOrder.length >= maxSize && !_cache.containsKey(userId)) {
      final oldestId = _accessOrder.removeAt(0);
      _cache.remove(oldestId);
    } else if (_cache.containsKey(userId) && _cache[userId] == user) {
      needsNotify = false;
    }

    // Update cache
    _cache[userId] = user;
    _accessOrder.remove(userId);
    _accessOrder.add(userId);

    if (needsNotify) {
      notifyListeners();
    }
  }
}
