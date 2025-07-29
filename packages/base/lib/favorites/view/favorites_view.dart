import 'package:base/favorites/controller/favorites_controller.dart';
import 'package:core/core.dart' hide RefreshIndicator;
import 'package:flutter/material.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  Widget build(BuildContext context, FavoritesController controller) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'Restoran Favorit',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          if (controller.favorites.isNotEmpty)
            IconButton(
              onPressed: controller.clearAllFavorites,
              icon: const Icon(Icons.clear_all),
              tooltip: 'Hapus Semua',
            ),
        ],
      ),
      body: Material(
        child: RefreshIndicator(
          onRefresh: controller.refreshFavorites,
          child: controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.favorites.isEmpty
                  ? _buildEmptyState(context)
                  : _buildFavoritesList(context, controller),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_outline,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Belum Ada Favorit',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tambahkan restoran ke favorit untuk melihatnya di sini',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop(); // Go back to home
            },
            icon: const Icon(Icons.explore),
            label: const Text('Jelajahi Restoran'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList(
      BuildContext context, FavoritesController controller) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: controller.favorites.length + 1, // +1 for header
      itemBuilder: (context, index) {
        if (index == 0) {
          // Header section
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total: ${controller.favorites.length} restoran',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        }

        // Favorite restaurant card
        final favorite = controller.favorites[index - 1];
        return Column(
          children: [
            _buildFavoriteCard(
              context: context,
              favorite: favorite,
              controller: controller,
            ),
            const SizedBox(height: 12),
          ],
        );
      },
    );
  }

  Widget _buildFavoriteCard({
    required BuildContext context,
    required FavoriteRestaurant favorite,
    required FavoritesController controller,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
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
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Restaurant Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  image: favorite.pictureId != null
                      ? DecorationImage(
                          image: NetworkImage(
                            'https://restaurant-api.dicoding.dev/images/medium/${favorite.pictureId}',
                          ),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: favorite.pictureId == null
                    ? const Icon(
                        Icons.restaurant,
                        color: Colors.grey,
                        size: 30,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 12),

            // Restaurant Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    favorite.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          favorite.city ?? 'Unknown City',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (favorite.rating != null) ...[
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.star,
                          size: 14,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          favorite.rating!.toStringAsFixed(1),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Ditambahkan: ${_formatDate(favorite.addedAt)}',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 11,
                    ),
                  ),
                  if (favorite.description != null &&
                      favorite.description!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      favorite.description!,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),

            // Remove from Favorites Button
            Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    await controller.removeFromFavorites(favorite);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
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

  @override
  State<FavoritesView> createState() => FavoritesController();
}
