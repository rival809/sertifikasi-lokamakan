import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:core/models/restaurant_review_model.dart';
import 'package:core/models/user_model.dart';
import 'package:core/services/review_service.dart';

class ReviewWidgets {
  /// Widget untuk menampilkan daftar review
  static Widget buildReviewsList({
    required String restaurantId,
    required List<RestaurantReview> reviews,
    required bool isLoading,
    VoidCallback? onLoadMore,
  }) {
    // Debug: Print reviews data
    print('Building reviews list for restaurant: $restaurantId');
    print('Reviews count: ${reviews.length}');
    print('Is loading: $isLoading');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Review Pengunjung',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (isLoading && reviews.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          )
        else if (reviews.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.rate_review_outlined,
                    size: 48,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Belum ada review',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Jadilah yang pertama memberikan review!',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reviews.length + (isLoading ? 1 : 0),
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              if (index == reviews.length) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return _buildReviewCard(reviews[index]);
            },
          ),
      ],
    );
  }

  /// Widget untuk card review individual
  static Widget _buildReviewCard(RestaurantReview review) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[300],
            backgroundImage: review.userPhotoUrl != null
                ? NetworkImage(review.userPhotoUrl!)
                : null,
            child: review.userPhotoUrl == null
                ? const Icon(Icons.person, color: Colors.grey)
                : null,
          ),
          const SizedBox(width: 12),
          // Review content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User name and date
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        review.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      review.formattedDate,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Review text
                Text(
                  review.reviewText,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Widget untuk form menambah review
  static Widget buildAddReviewForm({
    required BuildContext context,
    required UserModel? currentUser,
    required String restaurantId,
    required VoidCallback onReviewAdded,
  }) {
    if (currentUser == null) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
              top: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
          )),
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(width: 8),
            Text(
              'Login untuk memberikan review',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        border: Border(
            top: BorderSide(
          color: Theme.of(context).colorScheme.onSurface,
        )),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Berikan Review',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _ReviewForm(
            restaurantId: restaurantId,
            currentUser: currentUser,
            onReviewAdded: onReviewAdded,
          ),
        ],
      ),
    );
  }

  /// Widget untuk menampilkan summary review
  static Widget buildReviewSummary(RestaurantReviewSummary? summary) {
    if (summary == null || summary.totalReviews == 0) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          const Icon(
            Icons.rate_review,
            size: 16,
            color: Colors.grey,
          ),
          const SizedBox(width: 4),
          Text(
            '${summary.totalReviews} review',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

/// Form widget untuk menambah review
class _ReviewForm extends StatefulWidget {
  final String restaurantId;
  final UserModel currentUser;
  final VoidCallback onReviewAdded;

  const _ReviewForm({
    required this.restaurantId,
    required this.currentUser,
    required this.onReviewAdded,
  });

  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<_ReviewForm> {
  final TextEditingController _reviewController = TextEditingController();
  bool _isSubmitting = false;
  RestaurantReview? _existingReview;

  @override
  void initState() {
    super.initState();
    _checkExistingReview();
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _checkExistingReview() async {
    final review = await ReviewService.getUserReviewForRestaurant(
      widget.restaurantId,
      widget.currentUser.uid,
    );

    if (review != null) {
      _existingReview = review;
      _reviewController.text = review.reviewText;
      update();
    }
  }

  Future<void> _submitReview() async {
    if (_reviewController.text.trim().isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Review tidak boleh kosong')),
        );
      }
      return;
    }

    if (_reviewController.text.length > 200) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Review maksimal 200 karakter')),
        );
      }
      return;
    }

    _isSubmitting = true;
    update();

    bool success = false;

    if (_existingReview != null) {
      // Update existing review
      success = await ReviewService.updateReview(
        reviewId: _existingReview!.id,
        userId: widget.currentUser.uid,
        reviewText: _reviewController.text.trim(),
      );
    } else {
      // Add new review
      success = await ReviewService.addReview(
        restaurantId: widget.restaurantId,
        user: widget.currentUser,
        reviewText: _reviewController.text.trim(),
      );
    }

    _isSubmitting = false;
    update();

    if (success && mounted) {
      _reviewController.clear();
      widget.onReviewAdded();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_existingReview != null
              ? 'Review berhasil diperbarui!'
              : 'Review berhasil ditambahkan!'),
        ),
      );
      await _checkExistingReview(); // Refresh existing review status
    } else if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menyimpan review')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Review text field
        TextField(
          controller: _reviewController,
          maxLines: 3,
          maxLength: 200,
          decoration: InputDecoration(
            hintText: _existingReview != null
                ? 'Edit review Anda...'
                : 'Tulis review Anda...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
        const SizedBox(height: 12),
        // Submit button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isSubmitting ? null : _submitReview,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: _isSubmitting
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(_existingReview != null
                    ? 'Perbarui Review'
                    : 'Kirim Review'),
          ),
        ),
        if (_existingReview != null) ...[
          const SizedBox(height: 8),
          TextButton(
            onPressed: _isSubmitting
                ? null
                : () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Hapus Review'),
                        content:
                            const Text('Yakin ingin menghapus review Anda?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Hapus'),
                          ),
                        ],
                      ),
                    );

                    if (confirmed == true) {
                      if (mounted) {
                        setState(() {
                          _isSubmitting = true;
                        });
                      }

                      final success = await ReviewService.deleteReview(
                        reviewId: _existingReview!.id,
                        userId: widget.currentUser.uid,
                      );

                      if (mounted) {
                        setState(() {
                          _isSubmitting = false;
                        });

                        if (success) {
                          _reviewController.clear();
                          setState(() {
                            _existingReview = null;
                          });
                          widget.onReviewAdded();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Review berhasil dihapus')),
                          );
                        }
                      }
                    }
                  },
            child: const Text(
              'Hapus Review',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ],
    );
  }
}
