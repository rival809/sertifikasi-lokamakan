import 'package:base/base.dart';
import 'package:base/favorites/controller/favorites_controller.dart';
import 'package:base/restaurant_detail/view/restaurant_detail_view.dart';
import 'package:core/core.dart' hide RefreshIndicator;
import 'package:flutter/material.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  Widget build(BuildContext context, FavoritesController controller) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: BaseAppDrawer.beranda(
        onRestaurantListTap: () {
          // Use back navigation instead of push to avoid stack issues
          Get.back();
        },
        onFavoriteTap: () {},
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context)
              .colorScheme
              .onSurface, // Ganti dengan warna yang kamu inginkan
        ),
        title: Text(
          'Restoran Favorit',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
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
              newRouter.push(RouterUtils.beranda);
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        }

        // Favorite restaurant card
        final favorite = controller.favorites[index - 1];

        // Convert FavoriteRestaurant to RestaurantLocation for consistent card display
        final restaurantLocation = RestaurantLocation(
          id: favorite.id,
          name: favorite.name,
          location: const GeoPoint(0, 0), // Default location for favorites
          address: favorite.address ?? '',
          city: favorite.city ?? 'Unknown City',
          rating: favorite.rating,
          pictureUrl: favorite.pictureId, // Firebase sudah return URL lengkap
          description: favorite.description,
        );

        return Column(
          children: [
            BaseRestaurantCard.withFavorite(
              restaurant: restaurantLocation,
              isFavorite: true, // Always true in favorites list
              onFavoriteToggle: () async {
                await controller.removeFromFavorites(favorite);
              },
              addedAt: favorite.addedAt, // Tampilkan waktu ditambahkan
              onTap: () {
                Get.to(RestaurantDetailView(restaurant: restaurantLocation));
              },
            ),
            const SizedBox(height: 12),
          ],
        );
      },
    );
  }

  @override
  State<FavoritesView> createState() => FavoritesController();
}
