import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';

// Restaurant Location Model untuk LBS dengan Firebase GeoPoint
class RestaurantLocation {
  final String id;
  final String name;
  final GeoPoint location; // Firebase GeoPoint untuk koordinat
  final String address;
  final String city;
  final double? rating;
  final String? pictureUrl; // Direct URL ke gambar restoran
  final String? description; // Deskripsi restoran
  final double? distance; // Distance from user in kilometers

  const RestaurantLocation({
    required this.id,
    required this.name,
    required this.location,
    required this.address,
    required this.city,
    this.rating,
    this.pictureUrl,
    this.description,
    this.distance,
  });

  // Computed properties untuk backward compatibility
  double get latitude => location.latitude;
  double get longitude => location.longitude;

  factory RestaurantLocation.fromJson(Map<String, dynamic> json) {
    // Handle both GeoPoint and separate lat/lng fields for backward compatibility
    GeoPoint geoPoint;

    if (json['location'] != null && json['location'] is GeoPoint) {
      // New format with GeoPoint
      geoPoint = json['location'] as GeoPoint;
    } else if (json['latitude'] != null && json['longitude'] != null) {
      // Old format with separate lat/lng fields
      final lat = (json['latitude'] ?? 0.0).toDouble();
      final lng = (json['longitude'] ?? 0.0).toDouble();
      geoPoint = GeoPoint(lat, lng);
    } else {
      // Default fallback (Sumedang center)
      geoPoint = const GeoPoint(-6.8571, 107.9207);
    }

    return RestaurantLocation(
      id: json['id'] ?? json['uid'] ?? '',
      name: json['name'] ?? '',
      location: geoPoint,
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      rating: json['rating']?.toDouble(),
      pictureUrl: json['pictureUrl'] ??
          json['pictureId'], // Support both for backward compatibility
      description: json['description'], // Deskripsi restoran
      distance: json['distance']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location, // Firebase akan auto-serialize GeoPoint
      'address': address,
      'city': city,
      'rating': rating,
      'pictureUrl': pictureUrl,
      'description': description,
      'distance': distance,
    };
  }

  // Alternative toJson with separate lat/lng for compatibility
  Map<String, dynamic> toJsonWithLatLng() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'city': city,
      'rating': rating,
      'pictureUrl': pictureUrl,
      'description': description,
      'distance': distance,
    };
  }

  RestaurantLocation copyWith({
    String? id,
    String? name,
    GeoPoint? location,
    String? address,
    String? city,
    double? rating,
    String? pictureUrl,
    String? description,
    double? distance,
  }) {
    return RestaurantLocation(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      address: address ?? this.address,
      city: city ?? this.city,
      rating: rating ?? this.rating,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      description: description ?? this.description,
      distance: distance ?? this.distance,
    );
  }

  // Helper method untuk membuat GeoPoint dari lat/lng
  static GeoPoint createGeoPoint(double latitude, double longitude) {
    return GeoPoint(latitude, longitude);
  }

  // Helper method untuk menghitung distance dari GeoPoint lain
  double distanceFromGeoPoint(GeoPoint otherLocation) {
    return _calculateDistance(
        latitude, longitude, otherLocation.latitude, otherLocation.longitude);
  }

  // Haversine formula untuk distance calculation
  static double _calculateDistance(
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
