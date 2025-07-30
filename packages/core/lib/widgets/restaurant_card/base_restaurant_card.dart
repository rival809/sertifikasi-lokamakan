import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Interface untuk data restoran yang bisa ditampilkan di card
abstract class RestaurantCardData {
  String get id;
  String get name;
  String? get city;
  String? get description;
  String? get pictureUrl;
  double? get rating;
}

/// Extension untuk RestaurantLocation agar implement RestaurantCardData
extension RestaurantLocationCardData on RestaurantLocation {
  RestaurantCardData get asCardData => _RestaurantLocationCardData(this);
}

/// Extension untuk FavoriteRestaurant agar implement RestaurantCardData
extension FavoriteRestaurantCardData on FavoriteRestaurant {
  RestaurantCardData get asCardData => _FavoriteRestaurantCardData(this);
}

/// Implementation untuk RestaurantLocation
class _RestaurantLocationCardData implements RestaurantCardData {
  final RestaurantLocation _restaurant;

  _RestaurantLocationCardData(this._restaurant);

  @override
  String get id => _restaurant.id;

  @override
  String get name => _restaurant.name;

  @override
  String? get city => _restaurant.city;

  @override
  String? get description => _restaurant.description;

  @override
  String? get pictureUrl => _restaurant.pictureUrl;

  @override
  double? get rating => _restaurant.rating;
}

/// Implementation untuk FavoriteRestaurant
class _FavoriteRestaurantCardData implements RestaurantCardData {
  final FavoriteRestaurant _favorite;

  _FavoriteRestaurantCardData(this._favorite);

  @override
  String get id => _favorite.id;

  @override
  String get name => _favorite.name;

  @override
  String? get city => _favorite.city;

  @override
  String? get description => _favorite.description;

  @override
  String? get pictureUrl =>
      _favorite.pictureId; // Firebase sudah return URL lengkap

  @override
  double? get rating => _favorite.rating;
}

/// Widget reusable untuk menampilkan restaurant card
class BaseRestaurantCard extends StatelessWidget {
  final RestaurantCardData restaurant;
  final VoidCallback? onTap;
  final Widget? trailingWidget;
  final String? subtitle;
  final bool showDistance;
  final double? distance;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final double imageSize;
  final DateTime? addedAt; // Untuk menampilkan waktu di favorites

  const BaseRestaurantCard({
    super.key,
    required this.restaurant,
    this.onTap,
    this.trailingWidget,
    this.subtitle,
    this.showDistance = false,
    this.distance,
    this.padding,
    this.borderRadius,
    this.imageSize = 60,
    this.addedAt,
  });

  /// Factory constructor untuk RestaurantLocation dengan favorite toggle
  factory BaseRestaurantCard.withFavorite({
    Key? key,
    required RestaurantLocation restaurant,
    required bool isFavorite,
    required VoidCallback onFavoriteToggle,
    VoidCallback? onTap,
    bool showDistance = false,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    double imageSize = 60,
    DateTime? addedAt, // Optional untuk favorites
  }) {
    return BaseRestaurantCard(
      key: key,
      restaurant: restaurant.asCardData,
      onTap: onTap,
      showDistance: showDistance,
      distance: restaurant.distance,
      padding: padding,
      borderRadius: borderRadius,
      imageSize: imageSize,
      addedAt: addedAt,
      trailingWidget: _FavoriteToggleButton(
        isFavorite: isFavorite,
        onToggle: onFavoriteToggle,
      ),
    );
  }

  /// Factory constructor untuk FavoriteRestaurant dengan remove button
  factory BaseRestaurantCard.favoriteItem({
    Key? key,
    required FavoriteRestaurant favorite,
    required VoidCallback onRemove,
    VoidCallback? onTap,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    double imageSize = 60,
  }) {
    final dateText = _formatFavoriteDate(favorite.addedAt);
    return BaseRestaurantCard(
      key: key,
      restaurant: favorite.asCardData,
      onTap: onTap,
      subtitle: 'Ditambahkan: $dateText',
      padding: padding,
      borderRadius: borderRadius,
      imageSize: imageSize,
      trailingWidget: _RemoveFavoriteButton(onRemove: onRemove),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Restaurant Image
              _buildRestaurantImage(context),
              const SizedBox(width: 12),

              // Restaurant Info
              Expanded(
                child: _buildRestaurantInfo(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: imageSize,
        height: imageSize,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
        ),
        child: _buildImageWithFallback(context),
      ),
    );
  }

  Widget _buildImageWithFallback(BuildContext context) {
    final imageUrl = restaurant.pictureUrl;

    if (imageUrl == null || imageUrl.isEmpty) {
      return _buildImagePlaceholder(context);
    }

    // Fallback image that is known to work
    const fallbackImageUrl =
        'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=400&q=80';

    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    (loadingProgress.expectedTotalBytes ?? 1)
                : null,
            strokeWidth: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        // Suppress 404 error logging to avoid console spam
        if (!error.toString().contains('404')) {
          debugPrint('Error loading restaurant card image: $error');
        }

        // Try fallback image
        if (imageUrl != fallbackImageUrl) {
          return Image.network(
            fallbackImageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error2, stackTrace2) {
              return _buildImagePlaceholder(context);
            },
          );
        }

        // If even fallback fails, show placeholder
        return _buildImagePlaceholder(context);
      },
    );
  }

  Widget _buildImagePlaceholder(BuildContext context) {
    return Center(
      child: Icon(
        Icons.restaurant,
        size: imageSize / 2,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildRestaurantInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Restaurant Name
        Row(
          children: [
            Expanded(
              child: Text(
                restaurant.name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            if (showDistance && distance != null) ...[
              const SizedBox(width: 8),
              Icon(
                Icons.near_me,
                size: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                '${distance!.toStringAsFixed(1)} km',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 4),

        // Location and Rating Row
        Row(
          children: [
            Icon(
              Icons.location_on,
              size: 14,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                restaurant.city ?? '',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (restaurant.rating != null) ...[
              const SizedBox(width: 12),
              Icon(
                Icons.star,
                size: 14,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              const SizedBox(width: 4),
              Text(
                restaurant.rating!.toStringAsFixed(1),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 4.0),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (restaurant.description?.isNotEmpty == true ||
                subtitle != null) ...[
              Expanded(
                child: Text(
                  subtitle ?? restaurant.description ?? '',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
            // Trailing Widget (favorite button, remove button, etc.)
            if (trailingWidget != null) trailingWidget!,
          ],
        ),

        // Description or Subtitle

        // Time added for favorites
        if (addedAt != null) ...[
          const SizedBox(height: 4),
          Text(
            'Ditambahkan: ${_formatFavoriteDate(addedAt!)}',
            style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant
                  .withOpacity(0.7),
              fontSize: 11,
            ),
          ),
        ],
      ],
    );
  }

  /// Helper untuk format tanggal favorite
  static String _formatFavoriteDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} hari yang lalu';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} menit yang lalu';
    } else {
      return 'Baru saja';
    }
  }
}

/// Widget untuk favorite toggle button
class _FavoriteToggleButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onToggle;

  const _FavoriteToggleButton({
    required this.isFavorite,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.onSurface,
          size: 20,
        ),
      ),
    );
  }
}

/// Widget untuk remove favorite button
class _RemoveFavoriteButton extends StatelessWidget {
  final VoidCallback onRemove;

  const _RemoveFavoriteButton({required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onRemove,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Icon(
          Icons.favorite,
          color: Theme.of(context).colorScheme.error,
          size: 20,
        ),
      ),
    );
  }
}
