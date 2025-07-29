import 'package:flutter/material.dart';

/// Simple widget untuk menampilkan gambar restoran
/// Karena 1 resto = 1 gambar, tidak perlu complex architecture
class SimpleRestaurantImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const SimpleRestaurantImage({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: _buildImageWidget(),
    );
  }

  Widget _buildImageWidget() {
    // Jika tidak ada URL gambar, tampilkan placeholder
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _buildPlaceholder();
    }

    return Image.network(
      imageUrl!,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _buildLoadingWidget();
      },
      errorBuilder: (context, error, stackTrace) {
        return _buildPlaceholder();
      },
    );
  }

  /// Loading widget dengan shimmer effect
  Widget _buildLoadingWidget() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: borderRadius,
      ),
      child: const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
          ),
        ),
      ),
    );
  }

  /// Placeholder untuk restoran tanpa gambar
  Widget _buildPlaceholder() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: borderRadius,
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.restaurant,
            size: _getIconSize(),
            color: Colors.grey[400],
          ),
          if (_shouldShowText()) ...[
            const SizedBox(height: 4),
            Text(
              'No Image',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  double _getIconSize() {
    if (width != null && width! < 60) return 16;
    if (width != null && width! < 100) return 24;
    return 32;
  }

  bool _shouldShowText() {
    return width == null || width! >= 80;
  }
}

/// Widget khusus untuk card di list
class RestaurantCardImage extends StatelessWidget {
  final String? imageUrl;
  final double size;

  const RestaurantCardImage({
    super.key,
    this.imageUrl,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleRestaurantImage(
      imageUrl: imageUrl,
      width: size,
      height: size,
      borderRadius: BorderRadius.circular(8),
    );
  }
}

/// Widget khusus untuk detail page
class RestaurantDetailImage extends StatelessWidget {
  final String? imageUrl;
  final double height;

  const RestaurantDetailImage({
    super.key,
    this.imageUrl,
    this.height = 180,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleRestaurantImage(
      imageUrl: imageUrl,
      width: double.infinity,
      height: height,
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(12),
      ),
    );
  }
}
