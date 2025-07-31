import 'package:cloud_firestore/cloud_firestore.dart';

/// Model untuk review restoran
class RestaurantReview {
  final String id;
  final String restaurantId;
  final String userId;
  final String userName;
  final String? userPhotoUrl;
  final String reviewText;
  final DateTime createdAt;
  final DateTime updatedAt;

  RestaurantReview({
    required this.id,
    required this.restaurantId,
    required this.userId,
    required this.userName,
    this.userPhotoUrl,
    required this.reviewText,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Convert to Map for Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'userId': userId,
      'userName': userName,
      'userPhotoUrl': userPhotoUrl,
      'reviewText': reviewText,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  /// Create from Firestore Document
  factory RestaurantReview.fromJson(Map<String, dynamic> json) {
    return RestaurantReview(
      id: json['id'] ?? '',
      restaurantId: json['restaurantId'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? 'Anonymous',
      userPhotoUrl: json['userPhotoUrl'],
      reviewText: json['reviewText'] ?? '',
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  /// Copy with method for updates
  RestaurantReview copyWith({
    String? id,
    String? restaurantId,
    String? userId,
    String? userName,
    String? userPhotoUrl,
    String? reviewText,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RestaurantReview(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userPhotoUrl: userPhotoUrl ?? this.userPhotoUrl,
      reviewText: reviewText ?? this.reviewText,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Check if review text is valid (max 200 characters)
  bool get isValidReviewText =>
      reviewText.trim().isNotEmpty && reviewText.length <= 200;

  /// Get formatted date for display
  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 7) {
      return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} hari yang lalu';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} menit yang lalu';
    } else {
      return 'Baru saja';
    }
  }

  @override
  String toString() {
    return 'RestaurantReview(id: $id, restaurantId: $restaurantId, userId: $userId, userName: $userName, reviewText: $reviewText, createdAt: $createdAt)';
  }
}

/// Summary model untuk statistik review restoran
class RestaurantReviewSummary {
  final String restaurantId;
  final int totalReviews;
  final DateTime lastUpdated;

  RestaurantReviewSummary({
    required this.restaurantId,
    required this.totalReviews,
    required this.lastUpdated,
  });

  /// Convert to Map for Firestore
  Map<String, dynamic> toJson() {
    return {
      'restaurantId': restaurantId,
      'totalReviews': totalReviews,
      'lastUpdated': Timestamp.fromDate(lastUpdated),
    };
  }

  /// Create from Firestore Document
  factory RestaurantReviewSummary.fromJson(Map<String, dynamic> json) {
    return RestaurantReviewSummary(
      restaurantId: json['restaurantId'] ?? '',
      totalReviews: json['totalReviews'] ?? 0,
      lastUpdated:
          (json['lastUpdated'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  RestaurantReviewSummary copyWith({
    String? restaurantId,
    int? totalReviews,
    DateTime? lastUpdated,
  }) {
    return RestaurantReviewSummary(
      restaurantId: restaurantId ?? this.restaurantId,
      totalReviews: totalReviews ?? this.totalReviews,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
