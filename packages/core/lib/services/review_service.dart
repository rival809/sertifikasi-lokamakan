import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/models/restaurant_review_model.dart';
import 'package:core/models/user_model.dart';
import 'dart:developer';

class ReviewService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection references
  static CollectionReference<Map<String, dynamic>> get _reviewsCollection =>
      _firestore.collection('restaurant_reviews');

  static CollectionReference<Map<String, dynamic>>
      get _reviewSummaryCollection =>
          _firestore.collection('restaurant_review_summary');

  /// Get reviews for a specific restaurant
  static Future<List<RestaurantReview>> getRestaurantReviews(
    String restaurantId, {
    int limit = 20,
    DocumentSnapshot? lastDocument,
  }) async {
    try {
      log('Fetching reviews for restaurant: $restaurantId');

      // Optimal query with orderBy (requires index to be created first)
      Query<Map<String, dynamic>> query = _reviewsCollection
          .where('restaurantId', isEqualTo: restaurantId)
          .orderBy('createdAt', descending: true)
          .limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      final snapshot = await query.get();
      log('Found ${snapshot.docs.length} review documents');

      final reviews = snapshot.docs.map((doc) {
        final data = doc.data();
        log('Review data: $data');
        return RestaurantReview.fromJson(data);
      }).toList();

      log('Parsed ${reviews.length} reviews successfully');
      return reviews;
    } catch (e) {
      log('Error fetching restaurant reviews: $e');
      // Fallback: if index not ready yet, try simple query
      return await _getReviewsWithoutOrder(restaurantId, limit);
    }
  }

  /// Fallback method for when index is not ready
  static Future<List<RestaurantReview>> _getReviewsWithoutOrder(
      String restaurantId, int limit) async {
    try {
      log('Using fallback query without orderBy');

      final snapshot = await _reviewsCollection
          .where('restaurantId', isEqualTo: restaurantId)
          .limit(limit)
          .get();

      final reviews = snapshot.docs
          .map((doc) => RestaurantReview.fromJson(doc.data()))
          .toList();

      // Sort in memory
      reviews.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return reviews;
    } catch (e) {
      log('Error in fallback query: $e');
      return [];
    }
  }

  /// Get review summary for a restaurant
  static Future<RestaurantReviewSummary?> getRestaurantReviewSummary(
      String restaurantId) async {
    try {
      final doc = await _reviewSummaryCollection.doc(restaurantId).get();

      if (!doc.exists) {
        return RestaurantReviewSummary(
          restaurantId: restaurantId,
          totalReviews: 0,
          lastUpdated: DateTime.now(),
        );
      }

      return RestaurantReviewSummary.fromJson(doc.data()!);
    } catch (e) {
      log('Error fetching restaurant review summary: $e');
      return null;
    }
  }

  /// Add a new review
  static Future<bool> addReview({
    required String restaurantId,
    required UserModel user,
    required String reviewText,
  }) async {
    try {
      // Validate review text
      if (reviewText.trim().isEmpty || reviewText.length > 200) {
        log('Invalid review text length');
        return false;
      }

      // Check if user already reviewed this restaurant
      final existingReview =
          await getUserReviewForRestaurant(restaurantId, user.uid);
      if (existingReview != null) {
        log('User already reviewed this restaurant');
        return false;
      }

      final now = DateTime.now();
      final reviewId = _reviewsCollection.doc().id;

      final review = RestaurantReview(
        id: reviewId,
        restaurantId: restaurantId,
        userId: user.uid,
        userName: user.displayName ?? 'Anonymous',
        userPhotoUrl: user.photoURL,
        reviewText: reviewText.trim(),
        createdAt: now,
        updatedAt: now,
      );

      // Add review to collection
      await _reviewsCollection.doc(reviewId).set(review.toJson());

      // Update review summary
      await _updateReviewSummary(restaurantId);

      log('Review added successfully for restaurant: $restaurantId');
      return true;
    } catch (e) {
      log('Error adding review: $e');
      return false;
    }
  }

  /// Update an existing review
  static Future<bool> updateReview({
    required String reviewId,
    required String userId,
    required String reviewText,
  }) async {
    try {
      // Validate review text
      if (reviewText.trim().isEmpty || reviewText.length > 200) {
        log('Invalid review text length');
        return false;
      }

      final reviewDoc = await _reviewsCollection.doc(reviewId).get();
      if (!reviewDoc.exists) {
        log('Review not found: $reviewId');
        return false;
      }

      final review = RestaurantReview.fromJson(reviewDoc.data()!);

      // Check if user owns this review
      if (review.userId != userId) {
        log('User not authorized to update this review');
        return false;
      }

      final updatedReview = review.copyWith(
        reviewText: reviewText.trim(),
        updatedAt: DateTime.now(),
      );

      await _reviewsCollection.doc(reviewId).update(updatedReview.toJson());

      log('Review updated successfully: $reviewId');
      return true;
    } catch (e) {
      log('Error updating review: $e');
      return false;
    }
  }

  /// Delete a review
  static Future<bool> deleteReview({
    required String reviewId,
    required String userId,
  }) async {
    try {
      final reviewDoc = await _reviewsCollection.doc(reviewId).get();
      if (!reviewDoc.exists) {
        log('Review not found: $reviewId');
        return false;
      }

      final review = RestaurantReview.fromJson(reviewDoc.data()!);

      // Check if user owns this review
      if (review.userId != userId) {
        log('User not authorized to delete this review');
        return false;
      }

      await _reviewsCollection.doc(reviewId).delete();

      // Update review summary
      await _updateReviewSummary(review.restaurantId);

      log('Review deleted successfully: $reviewId');
      return true;
    } catch (e) {
      log('Error deleting review: $e');
      return false;
    }
  }

  /// Get user's review for a specific restaurant
  static Future<RestaurantReview?> getUserReviewForRestaurant(
      String restaurantId, String userId) async {
    try {
      final snapshot = await _reviewsCollection
          .where('restaurantId', isEqualTo: restaurantId)
          .where('userId', isEqualTo: userId)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;

      return RestaurantReview.fromJson(snapshot.docs.first.data());
    } catch (e) {
      log('Error fetching user review: $e');
      return null;
    }
  }

  /// Get recent reviews across all restaurants
  static Future<List<RestaurantReview>> getRecentReviews(
      {int limit = 10}) async {
    try {
      final snapshot = await _reviewsCollection
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs
          .map((doc) => RestaurantReview.fromJson(doc.data()))
          .toList();
    } catch (e) {
      log('Error fetching recent reviews: $e');
      return [];
    }
  }

  /// Update review summary for a restaurant
  static Future<void> _updateReviewSummary(String restaurantId) async {
    try {
      final snapshot = await _reviewsCollection
          .where('restaurantId', isEqualTo: restaurantId)
          .get();

      final summary = RestaurantReviewSummary(
        restaurantId: restaurantId,
        totalReviews: snapshot.docs.length,
        lastUpdated: DateTime.now(),
      );

      await _reviewSummaryCollection.doc(restaurantId).set(summary.toJson());
    } catch (e) {
      log('Error updating review summary: $e');
    }
  }

  /// Validate review text
  static bool isValidReviewText(String text) {
    return text.trim().isNotEmpty && text.length <= 200;
  }
}
