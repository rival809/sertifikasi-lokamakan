import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantDetailModel {
  final String id;
  final String name;
  final String description;
  final String address;
  final String city;
  final GeoPoint location;
  final double? rating;
  final int? ratingCount;
  final String? pictureUrl;
  final List<String> categories;
  final String? priceRange;
  final Map<String, dynamic>? openHours;
  final List<String> facilities;
  final Map<String, String>? contact;
  final List<String>? gallery;
  final double? distance;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const RestaurantDetailModel({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.city,
    required this.location,
    this.rating,
    this.ratingCount,
    this.pictureUrl,
    this.categories = const [],
    this.priceRange,
    this.openHours,
    this.facilities = const [],
    this.contact,
    this.gallery,
    this.distance,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  factory RestaurantDetailModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return RestaurantDetailModel(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      address: data['address'] ?? '',
      city: data['city'] ?? '',
      location: data['location'] ?? const GeoPoint(0, 0),
      rating: (data['rating']?['average'] ?? 0).toDouble(),
      ratingCount: data['rating']?['count'] ?? 0,
      pictureUrl: data['images']?['thumbnail'],
      categories: List<String>.from(data['categories'] ?? []),
      priceRange: data['priceRange'],
      openHours: data['openHours'],
      facilities: List<String>.from(data['facilities'] ?? []),
      contact: data['contact'] != null
          ? Map<String, String>.from(data['contact'])
          : null,
      gallery: data['images']?['gallery'] != null
          ? List<String>.from(data['images']['gallery'])
          : null,
      isActive: data['isActive'] ?? true,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  RestaurantDetailModel copyWith({
    String? id,
    String? name,
    String? description,
    String? address,
    String? city,
    GeoPoint? location,
    double? rating,
    int? ratingCount,
    String? pictureUrl,
    List<String>? categories,
    String? priceRange,
    Map<String, dynamic>? openHours,
    List<String>? facilities,
    Map<String, String>? contact,
    List<String>? gallery,
    double? distance,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RestaurantDetailModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      city: city ?? this.city,
      location: location ?? this.location,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      categories: categories ?? this.categories,
      priceRange: priceRange ?? this.priceRange,
      openHours: openHours ?? this.openHours,
      facilities: facilities ?? this.facilities,
      contact: contact ?? this.contact,
      gallery: gallery ?? this.gallery,
      distance: distance ?? this.distance,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Helper methods for UI
  String get formattedRating {
    if (rating == null) return 'Belum ada rating';
    return '${rating!.toStringAsFixed(1)} (${ratingCount ?? 0} review)';
  }

  String get formattedDistance {
    if (distance == null) return '';
    if (distance! < 1) {
      return '${(distance! * 1000).round()} m';
    }
    return '${distance!.toStringAsFixed(1)} km';
  }

  String get formattedPrice {
    switch (priceRange) {
      case '\$':
        return 'Murah (< Rp 50.000)';
      case '\$\$':
        return 'Sedang (Rp 50.000 - 150.000)';
      case '\$\$\$':
        return 'Mahal (Rp 150.000 - 300.000)';
      case '\$\$\$\$':
        return 'Sangat Mahal (> Rp 300.000)';
      default:
        return 'Harga tidak tersedia';
    }
  }

  bool get isOpenNow {
    if (openHours == null) return true;

    final now = DateTime.now();
    final dayNames = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday'
    ];
    final today = dayNames[now.weekday - 1];

    final todayHours = openHours![today];
    if (todayHours == null) return false;

    final openTime = todayHours['open'];
    final closeTime = todayHours['close'];

    if (openTime == null || closeTime == null) return true;

    final currentTime =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    return currentTime.compareTo(openTime) >= 0 &&
        currentTime.compareTo(closeTime) <= 0;
  }

  String get openStatus {
    return isOpenNow ? 'Buka' : 'Tutup';
  }
}
