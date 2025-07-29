import 'package:core/core.dart';

class FavoriteService {
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
    return await FavoriteDatabase.toggleFavorite(
      restaurantId: restaurantId,
      restaurantName: restaurantName,
      description: description,
      city: city,
      address: address,
      pictureId: pictureId,
      rating: rating,
    );
  }

  /// Check if a restaurant is in favorites
  static Future<bool> isFavorite(String restaurantId) async {
    return await FavoriteDatabase.isFavorite(restaurantId);
  }

  /// Add a restaurant to favorites
  static Future<bool> addToFavorites(RestaurantLocation restaurant) async {
    return await FavoriteDatabase.addToFavorites(
      restaurantId: restaurant.id,
      restaurantName: restaurant.name,
      description: restaurant.description,
      city: restaurant.city,
      address: restaurant.address,
      pictureId: restaurant.pictureUrl,
      rating: restaurant.rating,
    );
  }

  /// Get all favorite restaurants for the current user
  static Future<List<FavoriteRestaurant>> getAllFavorites() async {
    return await FavoriteDatabase.getAllFavorites();
  }

  /// Get favorites count
  static Future<int> getFavoritesCount() async {
    return await FavoriteDatabase.getFavoritesCount();
  }

  /// Remove a restaurant from favorites
  static Future<bool> removeFromFavorites(String restaurantId) async {
    return await FavoriteDatabase.removeFromFavorites(restaurantId);
  }

  /// Clear all favorites for current user
  static Future<bool> clearUserFavorites() async {
    return await FavoriteDatabase.clearUserFavorites();
  }

  /// Get stream of favorites for real-time updates
  static Stream<List<FavoriteRestaurant>> getFavoritesStream() {
    return FavoriteDatabase.getFavoritesStream();
  }
}
