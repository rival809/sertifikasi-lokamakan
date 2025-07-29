import 'dart:developer' as dev;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:core/database/favorite_restaurant_model.dart';
import 'package:core/services/session_service.dart';

class FavoriteDatabase {
  static const String _boxName = 'favorite_restaurants';
  static Box<FavoriteRestaurant>? _box;

  /// Initialize Hive database for favorites
  static Future<void> init() async {
    await Hive.initFlutter();

    // Register the FavoriteRestaurant adapter if not already registered
    if (!Hive.isAdapterRegistered(10)) {
      Hive.registerAdapter(FavoriteRestaurantAdapter());
    }

    // Open the favorites box
    _box = await Hive.openBox<FavoriteRestaurant>(_boxName);
  }

  /// Get the current user's ID for filtering favorites
  static String? get _currentUserId {
    return SessionService.currentUserData?.uid;
  }

  /// Add a restaurant to favorites
  static Future<bool> addToFavorites({
    required String restaurantId,
    required String restaurantName,
    String? description,
    String? city,
    String? address,
    String? pictureId,
    double? rating,
  }) async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        throw Exception('User not logged in');
      }

      if (_box == null) {
        await init();
      }

      // Check if already exists
      if (await isFavorite(restaurantId)) {
        return false; // Already in favorites
      }

      final favorite = FavoriteRestaurant.fromRestaurant(
        restaurantId: restaurantId,
        restaurantName: restaurantName,
        description: description,
        city: city,
        address: address,
        pictureId: pictureId,
        rating: rating,
        userId: userId,
      );

      // Use a unique key combining restaurantId and userId
      final key = '${restaurantId}_$userId';
      await _box!.put(key, favorite);
      return true;
    } catch (e) {
      dev.log('Error adding to favorites: $e');
      return false;
    }
  }

  /// Remove a restaurant from favorites
  static Future<bool> removeFromFavorites(String restaurantId) async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        throw Exception('User not logged in');
      }

      if (_box == null) {
        await init();
      }

      final key = '${restaurantId}_$userId';
      await _box!.delete(key);
      return true;
    } catch (e) {
      dev.log('Error removing from favorites: $e');
      return false;
    }
  }

  /// Check if a restaurant is in favorites
  static Future<bool> isFavorite(String restaurantId) async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return false;
      }

      if (_box == null) {
        await init();
      }

      final key = '${restaurantId}_$userId';
      return _box!.containsKey(key);
    } catch (e) {
      dev.log('Error checking favorite status: $e');
      return false;
    }
  }

  /// Get all favorites for the current user
  static Future<List<FavoriteRestaurant>> getAllFavorites() async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return [];
      }

      if (_box == null) {
        await init();
      }

      final allFavorites = _box!.values.toList();
      // Filter by current user
      final userFavorites =
          allFavorites.where((favorite) => favorite.userId == userId).toList();

      // Sort by addedAt (newest first)
      userFavorites.sort((a, b) => b.addedAt.compareTo(a.addedAt));

      return userFavorites;
    } catch (e) {
      dev.log('Error getting favorites: $e');
      return [];
    }
  }

  /// Get favorites count for the current user
  static Future<int> getFavoritesCount() async {
    final favorites = await getAllFavorites();
    return favorites.length;
  }

  /// Clear all favorites for the current user
  static Future<bool> clearUserFavorites() async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return false;
      }

      if (_box == null) {
        await init();
      }

      // Get all keys for current user
      final keysToDelete = <String>[];
      for (final key in _box!.keys) {
        if (key.toString().endsWith('_$userId')) {
          keysToDelete.add(key.toString());
        }
      }

      // Delete all user's favorites
      await _box!.deleteAll(keysToDelete);
      return true;
    } catch (e) {
      dev.log('Error clearing favorites: $e');
      return false;
    }
  }

  /// Toggle favorite status for a restaurant
  static Future<bool> toggleFavorite({
    required String restaurantId,
    required String restaurantName,
    String? description,
    String? city,
    String? address,
    String? pictureId,
    double? rating,
  }) async {
    final isCurrentlyFavorite = await isFavorite(restaurantId);

    if (isCurrentlyFavorite) {
      return await removeFromFavorites(restaurantId);
    } else {
      return await addToFavorites(
        restaurantId: restaurantId,
        restaurantName: restaurantName,
        description: description,
        city: city,
        address: address,
        pictureId: pictureId,
        rating: rating,
      );
    }
  }

  /// Close the database
  static Future<void> close() async {
    await _box?.close();
    _box = null;
  }

  /// Get stream of favorites for real-time updates
  static Stream<List<FavoriteRestaurant>> getFavoritesStream() async* {
    if (_box == null) {
      await init();
    }

    yield await getAllFavorites();

    await for (final _ in _box!.watch()) {
      yield await getAllFavorites();
    }
  }
}
