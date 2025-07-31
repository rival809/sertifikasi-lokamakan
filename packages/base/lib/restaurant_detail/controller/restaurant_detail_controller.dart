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

  // Menu related properties
  RestaurantMenu? restaurantMenu;
  bool isMenuLoading = false;
  String? selectedCategoryId;

  // Review related properties
  List<RestaurantReview> reviews = [];
  bool isReviewsLoading = false;
  RestaurantReviewSummary? reviewSummary;
  UserModel? currentUser;

  @override
  void initState() {
    super.initState();
    restaurant = widget.restaurant;
    _initializeData();
  }

  Future<void> _initializeData() async {
    isLoading = true;
    if (mounted) update();

    try {
      // Get current user
      await _getCurrentUser();

      // Check if restaurant is in favorites
      isFavorite = await FavoriteService.isFavorite(restaurant.id);

      // Get user location and calculate distance
      await _getCurrentLocationAndCalculateDistance();

      // Load restaurant menu
      await _loadRestaurantMenu();

      // Load restaurant reviews
      await _loadRestaurantReviews();
    } catch (e) {
      debugPrint('Error initializing restaurant detail: $e');
    } finally {
      isLoading = false;
      if (mounted) update();
    }
  }

  Future<void> _getCurrentUser() async {
    try {
      final firebaseUser = AuthService.currentUser;
      if (firebaseUser != null) {
        currentUser = UserModel.fromFirebaseUser(firebaseUser);
      }
    } catch (e) {
      debugPrint('Error getting current user: $e');
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

        if (mounted) update();
      }
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }

  Future<void> _loadRestaurantMenu() async {
    try {
      isMenuLoading = true;
      if (mounted) update();

      // Try to load existing menu from Firestore
      restaurantMenu = await MenuService.getRestaurantMenu(restaurant.id);

      // Set default selected category to first available category
      if (restaurantMenu != null &&
          restaurantMenu!.activeCategories.isNotEmpty) {
        selectedCategoryId = restaurantMenu!.activeCategories.first.id;
      }
    } catch (e) {
      debugPrint('Error loading restaurant menu: $e');
    } finally {
      isMenuLoading = false;
      if (mounted) update();
    }
  }

  Future<void> _loadRestaurantReviews() async {
    try {
      debugPrint('Loading reviews for restaurant: ${restaurant.id}');
      isReviewsLoading = true;
      if (mounted) update();

      // Load reviews and summary
      final reviewsData =
          await ReviewService.getRestaurantReviews(restaurant.id);
      final summaryData =
          await ReviewService.getRestaurantReviewSummary(restaurant.id);

      debugPrint('Loaded ${reviewsData.length} reviews');
      reviews = reviewsData;
      reviewSummary = summaryData;
    } catch (e) {
      debugPrint('Error loading restaurant reviews: $e');
    } finally {
      isReviewsLoading = false;
      if (mounted) update();
    }
  }

  Future<void> onReviewAdded() async {
    // Reload reviews when a new review is added
    if (mounted) {
      await _loadRestaurantReviews();
    }
  }

  void selectMenuCategory(String categoryId) {
    selectedCategoryId = categoryId;
    if (mounted) update();
  }

  List<MenuItem> get selectedCategoryItems {
    if (restaurantMenu == null || selectedCategoryId == null) return [];
    return restaurantMenu!.getItemsByCategory(selectedCategoryId!);
  }

  Future<void> toggleFavorite() async {
    try {
      if (isFavorite) {
        await FavoriteService.removeFromFavorites(restaurant.id);
      } else {
        await FavoriteService.addToFavorites(restaurant);
      }

      isFavorite = !isFavorite;
      if (mounted) update();

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
        'google.navigation:q=${restaurant.location.latitude},${restaurant.location.longitude}',
        'geo:${restaurant.location.latitude},${restaurant.location.longitude}?q=${restaurant.location.latitude},${restaurant.location.longitude}(${Uri.encodeComponent(restaurant.name)})',
        'https://www.google.com/maps/search/?api=1&query=${restaurant.location.latitude},${restaurant.location.longitude}',
        'https://www.google.com/maps/place/${restaurant.location.latitude},${restaurant.location.longitude}',
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
