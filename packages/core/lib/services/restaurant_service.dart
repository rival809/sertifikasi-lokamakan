import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/models/restaurant_location_model.dart';
import 'dart:developer';
import 'dart:math' as math;

class RestaurantService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection reference untuk restaurants
  static CollectionReference<Map<String, dynamic>> get _restaurantsCollection =>
      _firestore.collection('resto');

  /// Get all restaurants from Firestore
  static Future<List<RestaurantLocation>> getAllRestaurants() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _restaurantsCollection.get();

      final List<RestaurantLocation> restaurants = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // Ensure ID is set from document ID
        return RestaurantLocation.fromJson(data);
      }).toList();

      log('Fetched ${restaurants.length} restaurants from Firestore');
      return restaurants;
    } catch (e) {
      log('Error fetching restaurants: $e');
      return [];
    }
  }

  /// Get restaurants near a specific location with radius filter
  static Future<List<RestaurantLocation>> getNearbyRestaurants({
    required double userLatitude,
    required double userLongitude,
    double radiusKm = 50.0, // Default 50km radius
  }) async {
    try {
      // Get all restaurants first
      final List<RestaurantLocation> allRestaurants = await getAllRestaurants();

      // Calculate distances and filter by radius
      final List<RestaurantLocation> nearbyRestaurants = allRestaurants
          .map((restaurant) {
            final distance = calculateDistance(
              userLatitude,
              userLongitude,
              restaurant.latitude,
              restaurant.longitude,
            );

            return restaurant.copyWith(distance: distance);
          })
          .where((restaurant) =>
              (restaurant.distance ?? double.infinity) <= radiusKm)
          .toList();

      // Sort by distance (closest first)
      nearbyRestaurants
          .sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));

      log('Found ${nearbyRestaurants.length} restaurants within ${radiusKm}km');
      return nearbyRestaurants;
    } catch (e) {
      log('Error fetching nearby restaurants: $e');
      return [];
    }
  }

  /// Get restaurant by ID
  static Future<RestaurantLocation?> getRestaurantById(String id) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> doc =
          await _restaurantsCollection.doc(id).get();

      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        data['id'] = doc.id;
        return RestaurantLocation.fromJson(data);
      }

      return null;
    } catch (e) {
      log('Error fetching restaurant by ID: $e');
      return null;
    }
  }

  /// Stream restaurants for real-time updates
  static Stream<List<RestaurantLocation>> getRestaurantsStream() {
    return _restaurantsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return RestaurantLocation.fromJson(data);
      }).toList();
    });
  }

  /// Search restaurants by name or city
  static Future<List<RestaurantLocation>> searchRestaurants(
      String query) async {
    try {
      final String lowercaseQuery = query.toLowerCase();

      // Get all restaurants and filter locally
      // Note: Firestore doesn't support case-insensitive search natively
      final List<RestaurantLocation> allRestaurants = await getAllRestaurants();

      final List<RestaurantLocation> searchResults = allRestaurants
          .where((restaurant) =>
              restaurant.name.toLowerCase().contains(lowercaseQuery) ||
              restaurant.city.toLowerCase().contains(lowercaseQuery) ||
              restaurant.address.toLowerCase().contains(lowercaseQuery))
          .toList();

      log('Found ${searchResults.length} restaurants matching "$query"');
      return searchResults;
    } catch (e) {
      log('Error searching restaurants: $e');
      return [];
    }
  }

  /// Add new restaurant (for admin purposes)
  static Future<bool> addRestaurant(RestaurantLocation restaurant) async {
    try {
      await _restaurantsCollection.add(restaurant.toJson());
      log('Restaurant added successfully: ${restaurant.name}');
      return true;
    } catch (e) {
      log('Error adding restaurant: $e');
      return false;
    }
  }

  /// Update restaurant
  static Future<bool> updateRestaurant(RestaurantLocation restaurant) async {
    try {
      await _restaurantsCollection
          .doc(restaurant.id)
          .update(restaurant.toJson());
      log('Restaurant updated successfully: ${restaurant.name}');
      return true;
    } catch (e) {
      log('Error updating restaurant: $e');
      return false;
    }
  }

  /// Delete restaurant
  static Future<bool> deleteRestaurant(String id) async {
    try {
      await _restaurantsCollection.doc(id).delete();
      log('Restaurant deleted successfully: $id');
      return true;
    } catch (e) {
      log('Error deleting restaurant: $e');
      return false;
    }
  }

  /// Calculate distance between two coordinates using Haversine formula
  static double calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Earth radius in kilometers

    final double dLat = _degreesToRadians(lat2 - lat1);
    final double dLon = _degreesToRadians(lon2 - lon1);

    final double a = (math.sin(dLat / 2) * math.sin(dLat / 2)) +
        (math.cos(_degreesToRadians(lat1)) *
            math.cos(_degreesToRadians(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2));

    final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return earthRadius * c;
  }

  static double _degreesToRadians(double degrees) {
    return degrees * (math.pi / 180);
  }
}
