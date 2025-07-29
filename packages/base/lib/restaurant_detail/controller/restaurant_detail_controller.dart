import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:base/restaurant_detail/view/restaurant_detail_view.dart';
import 'package:base/routing/view/routing_view.dart';

class RestaurantDetailController extends State<RestaurantDetailView> {
  late RestaurantLocation restaurant;
  Position? userLocation;
  double? distance;
  bool isFavorite = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    restaurant = widget.restaurant;
    _initializeData();
  }

  Future<void> _initializeData() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Check if restaurant is in favorites
      isFavorite = await FavoriteService.isFavorite(restaurant.id);

      // Get user location and calculate distance
      await _getCurrentLocationAndCalculateDistance();
    } catch (e) {
      debugPrint('Error initializing restaurant detail: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _getCurrentLocationAndCalculateDistance() async {
    try {
      // Get current user location
      userLocation = await LocationService.getCurrentLocation();

      if (userLocation != null) {
        // Calculate distance to restaurant
        distance = LocationService.calculateDistance(
          userLocation!.latitude,
          userLocation!.longitude,
          restaurant.location.latitude,
          restaurant.location.longitude,
        );

        setState(() {});
      }
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }

  Future<void> toggleFavorite() async {
    try {
      if (isFavorite) {
        await FavoriteService.removeFromFavorites(restaurant.id);
      } else {
        await FavoriteService.addToFavorites(restaurant);
      }

      setState(() {
        isFavorite = !isFavorite;
      });

      // Notify about favorite change
      FavoriteEventManager.notifyFavoriteChanged();

      // Show feedback to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isFavorite
                  ? '${restaurant.name} ditambahkan ke favorit'
                  : '${restaurant.name} dihapus dari favorit',
            ),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal mengubah status favorit'),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> openDirections() async {
    if (userLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lokasi Anda tidak tersedia'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    try {
      // Navigate to routing page with flutter_map
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => RoutingView(
            restaurant: restaurant,
            userLocation: userLocation!,
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error opening routing page: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal membuka halaman navigasi'),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> openInMaps() async {
    try {
      // Try multiple URL formats for better compatibility
      List<String> urlFormats = [
        // Google Maps intent for Android
        'google.navigation:q=${restaurant.location.latitude},${restaurant.location.longitude}',
        // Geo URI for Android
        'geo:${restaurant.location.latitude},${restaurant.location.longitude}?q=${restaurant.location.latitude},${restaurant.location.longitude}(${Uri.encodeComponent(restaurant.name)})',
        // Google Maps search API
        'https://www.google.com/maps/search/?api=1&query=${restaurant.location.latitude},${restaurant.location.longitude}',
        // Google Maps with place query
        'https://www.google.com/maps/place/${restaurant.location.latitude},${restaurant.location.longitude}',
        // Simple Google Maps coordinate URL
        'https://maps.google.com/?q=${restaurant.location.latitude},${restaurant.location.longitude}',
      ];

      bool launched = false;

      for (String urlString in urlFormats) {
        try {
          final url = Uri.parse(urlString);
          debugPrint('Trying to launch: $urlString');

          if (await canLaunchUrl(url)) {
            launched =
                await launchUrl(url, mode: LaunchMode.externalApplication);
            if (launched) {
              debugPrint('Successfully launched: $urlString');
              break;
            }
          }
        } catch (e) {
          debugPrint('Failed to launch $urlString: $e');
          continue;
        }
      }

      if (!launched) {
        throw 'Could not launch any maps application';
      }
    } catch (e) {
      debugPrint('Error opening maps: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membuka peta: ${e.toString()}'),
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: 'Coba Lagi',
              onPressed: openInMaps,
            ),
          ),
        );
      }
    }
  }

  Future<void> shareRestaurant() async {
    try {
      final shareText = '''
🍽️ ${restaurant.name}

📍 ${restaurant.address}, ${restaurant.city}
⭐ Rating: ${restaurant.rating?.toStringAsFixed(1) ?? 'N/A'}
${distance != null ? '📏 Jarak: ${LocationService.formatDistance(distance)}' : ''}

${restaurant.description ?? ''}

📱 Lihat di Google Maps:
https://www.google.com/maps/search/?api=1&query=${restaurant.location.latitude},${restaurant.location.longitude}

#LokaMAkan #Restaurant #${restaurant.city}
      '''
          .trim();

      // Use share functionality (placeholder - would use share_plus package in real implementation)
      debugPrint('Sharing: $shareText');

      // For now, show dialog with share text
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Bagikan Restoran'),
            content: SingleChildScrollView(
              child: Text(shareText),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Tutup'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      debugPrint('Error sharing restaurant: $e');
    }
  }

  // ignore: unused_element
  String _formatDistance(double? dist) {
    if (dist == null) return '';
    if (dist < 1) {
      return '${(dist * 1000).round()} m';
    }
    return '${dist.toStringAsFixed(1)} km';
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, this);
  }
}
