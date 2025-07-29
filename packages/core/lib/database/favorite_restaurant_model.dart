import 'package:hive/hive.dart';

part 'favorite_restaurant_model.g.dart';

@HiveType(typeId: 10)
class FavoriteRestaurant extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final String? city;

  @HiveField(4)
  final String? address;

  @HiveField(5)
  final String? pictureId;

  @HiveField(6)
  final double? rating;

  @HiveField(7)
  final DateTime addedAt;

  @HiveField(8)
  final String userId; // To associate favorites with specific users

  FavoriteRestaurant({
    required this.id,
    required this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.rating,
    required this.addedAt,
    required this.userId,
  });

  factory FavoriteRestaurant.fromRestaurant({
    required String restaurantId,
    required String restaurantName,
    String? description,
    String? city,
    String? address,
    String? pictureId,
    double? rating,
    required String userId,
  }) {
    return FavoriteRestaurant(
      id: restaurantId,
      name: restaurantName,
      description: description,
      city: city,
      address: address,
      pictureId: pictureId,
      rating: rating,
      addedAt: DateTime.now(),
      userId: userId,
    );
  }

  @override
  String toString() {
    return 'FavoriteRestaurant{id: $id, name: $name, city: $city, rating: $rating, addedAt: $addedAt, userId: $userId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FavoriteRestaurant &&
        other.id == id &&
        other.userId == userId;
  }

  @override
  int get hashCode => id.hashCode ^ userId.hashCode;
}
