import 'dart:developer' as dev;
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:core/models/restaurant_location_model.dart';

class LocationService {
  static const double _earthRadius = 6371.0; // Earth's radius in kilometers

  /// Check if location services are enabled and permission is granted
  static Future<bool> isLocationServiceEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  /// Get current user location
  static Future<Position?> getCurrentLocation() async {
    try {
      bool hasPermission = await isLocationServiceEnabled();
      if (!hasPermission) {
        dev.log('Location permission not granted');
        return null;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      dev.log('Current location: ${position.latitude}, ${position.longitude}');
      return position;
    } catch (e) {
      dev.log('Error getting current location: $e');
      return null;
    }
  }

  /// Calculate distance between two points using Haversine formula
  static double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    // Convert latitude and longitude from degrees to radians
    double lat1Rad = lat1 * pi / 180;
    double lon1Rad = lon1 * pi / 180;
    double lat2Rad = lat2 * pi / 180;
    double lon2Rad = lon2 * pi / 180;

    // Haversine formula
    double dLat = lat2Rad - lat1Rad;
    double dLon = lon2Rad - lon1Rad;

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1Rad) * cos(lat2Rad) * sin(dLon / 2) * sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = _earthRadius * c;

    return distance;
  }

  /// Sort restaurants by distance from user location
  static List<RestaurantLocation> sortRestaurantsByDistance(
    List<RestaurantLocation> restaurants,
    double userLat,
    double userLon,
  ) {
    // Calculate distance for each restaurant
    List<RestaurantLocation> restaurantsWithDistance =
        restaurants.map((restaurant) {
      double distance = calculateDistance(
        userLat,
        userLon,
        restaurant.latitude,
        restaurant.longitude,
      );

      return restaurant.copyWith(distance: distance);
    }).toList();

    // Sort by distance
    restaurantsWithDistance
        .sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));

    return restaurantsWithDistance;
  }

  /// Filter restaurants within specified radius (in kilometers)
  static List<RestaurantLocation> filterRestaurantsByRadius(
    List<RestaurantLocation> restaurants,
    double userLat,
    double userLon,
    double radiusKm,
  ) {
    return restaurants.where((restaurant) {
      double distance = calculateDistance(
        userLat,
        userLon,
        restaurant.latitude,
        restaurant.longitude,
      );
      return distance <= radiusKm;
    }).toList();
  }

  /// Get restaurants near user location
  static Future<List<RestaurantLocation>> getNearbyRestaurants(
    List<RestaurantLocation> allRestaurants, {
    double radiusKm = 10.0, // Default radius 10km
  }) async {
    try {
      Position? userPosition = await getCurrentLocation();
      if (userPosition == null) {
        dev.log('Could not get user location');
        return allRestaurants; // Return all restaurants if location unavailable
      }

      // Filter and sort restaurants by distance
      List<RestaurantLocation> nearbyRestaurants = filterRestaurantsByRadius(
        allRestaurants,
        userPosition.latitude,
        userPosition.longitude,
        radiusKm,
      );

      nearbyRestaurants = sortRestaurantsByDistance(
        nearbyRestaurants,
        userPosition.latitude,
        userPosition.longitude,
      );

      dev.log(
          'Found ${nearbyRestaurants.length} restaurants within ${radiusKm}km');
      return nearbyRestaurants;
    } catch (e) {
      dev.log('Error getting nearby restaurants: $e');
      return allRestaurants;
    }
  }

  /// Format distance for display
  static String formatDistance(double? distanceKm) {
    if (distanceKm == null) return 'N/A';

    if (distanceKm < 1.0) {
      return '${(distanceKm * 1000).round()}m';
    } else {
      return '${distanceKm.toStringAsFixed(1)}km';
    }
  }

  /// Open device location settings
  static Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  /// Open app settings
  static Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  /// Check location permission status
  static Future<LocationPermission> getLocationPermission() async {
    return await Geolocator.checkPermission();
  }

  /// Request location permission
  static Future<LocationPermission> requestLocationPermission() async {
    return await Geolocator.requestPermission();
  }

  /// Get location accuracy settings
  static Future<LocationAccuracyStatus> getLocationAccuracy() async {
    return await Geolocator.getLocationAccuracy();
  }

  /// Get address from coordinates (Reverse Geocoding)
  static Future<String?> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        
        // Build address string from placemark components
        List<String> addressParts = [];
        
        // Add street/sublocality
        if (place.street != null && place.street!.isNotEmpty) {
          addressParts.add(place.street!);
        } else if (place.subLocality != null && place.subLocality!.isNotEmpty) {
          addressParts.add(place.subLocality!);
        }
        
        // Add locality/subadministrativearea
        if (place.locality != null && place.locality!.isNotEmpty) {
          addressParts.add(place.locality!);
        } else if (place.subAdministrativeArea != null && 
                  place.subAdministrativeArea!.isNotEmpty) {
          addressParts.add(place.subAdministrativeArea!);
        }
        
        // Add administrative area (state/province)
        if (place.administrativeArea != null && 
            place.administrativeArea!.isNotEmpty) {
          addressParts.add(place.administrativeArea!);
        }
        
        // Add country
        if (place.country != null && place.country!.isNotEmpty) {
          addressParts.add(place.country!);
        }
        
        String fullAddress = addressParts.join(', ');
        dev.log('Geocoded address: $fullAddress');
        return fullAddress.isNotEmpty ? fullAddress : null;
      }
      
      return null;
    } catch (e) {
      dev.log('Error during reverse geocoding: $e');
      return null;
    }
  }

  /// Get simplified address (locality and administrative area only)
  static Future<String?> getSimplifiedAddress(
    double latitude,
    double longitude,
  ) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        
        List<String> addressParts = [];
        
        // Add locality
        if (place.locality != null && place.locality!.isNotEmpty) {
          addressParts.add(place.locality!);
        } else if (place.subAdministrativeArea != null && 
                  place.subAdministrativeArea!.isNotEmpty) {
          addressParts.add(place.subAdministrativeArea!);
        }
        
        // Add administrative area (state/province)
        if (place.administrativeArea != null && 
            place.administrativeArea!.isNotEmpty) {
          addressParts.add(place.administrativeArea!);
        }
        
        String simplifiedAddress = addressParts.join(', ');
        dev.log('Simplified address: $simplifiedAddress');
        return simplifiedAddress.isNotEmpty ? simplifiedAddress : null;
      }
      
      return null;
    } catch (e) {
      dev.log('Error during simplified geocoding: $e');
      return null;
    }
  }

  /// Get current location with address
  static Future<Map<String, dynamic>?> getCurrentLocationWithAddress() async {
    try {
      Position? position = await getCurrentLocation();
      if (position == null) return null;

      String? address = await getSimplifiedAddress(
        position.latitude,
        position.longitude,
      );

      return {
        'position': position,
        'address': address,
        'coordinates': '${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}',
      };
    } catch (e) {
      dev.log('Error getting location with address: $e');
      return null;
    }
  }
}
