import 'package:base/favorites/view/favorites_view.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class FavoritesController extends State<FavoritesView> {
  static late FavoritesController instance;
  late FavoritesView view;

  List<FavoriteRestaurant> favorites = [];
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    instance = this;
    loadFavorites();
    super.initState();
  }

  // Load favorite restaurants
  Future<void> loadFavorites() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final favoriteList = await FavoriteService.getAllFavorites();
      setState(() {
        favorites = favoriteList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading favorites: $errorMessage'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Remove from favorites
  Future<void> removeFromFavorites(FavoriteRestaurant favorite) async {
    try {
      final success = await FavoriteService.removeFromFavorites(favorite.id);
      if (success) {
        setState(() {
          favorites.removeWhere((f) => f.id == favorite.id);
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${favorite.name} dihapus dari favorit'),
              backgroundColor: Colors.orange,
              action: SnackBarAction(
                label: 'UNDO',
                onPressed: () async {
                  // Re-add to favorites
                  await FavoriteService.toggleFavorite(
                    restaurantId: favorite.id,
                    restaurantName: favorite.name,
                    description: favorite.description,
                    city: favorite.city,
                    address: favorite.address,
                    pictureId: favorite.pictureId,
                    rating: favorite.rating,
                  );
                  await loadFavorites(); // Refresh list
                },
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Clear all favorites
  Future<void> clearAllFavorites() async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Semua Favorit'),
          content: const Text(
              'Apakah Anda yakin ingin menghapus semua restoran favorit?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Hapus Semua',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      try {
        final success = await FavoriteService.clearUserFavorites();
        if (success) {
          setState(() {
            favorites.clear();
          });

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Semua favorit telah dihapus'),
                backgroundColor: Colors.orange,
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  // Refresh favorites
  Future<void> refreshFavorites() async {
    await loadFavorites();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
