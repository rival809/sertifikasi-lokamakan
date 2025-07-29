import 'package:base/beranda/view/beranda_view.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class BerandaController extends State<BerandaView> with WidgetsBindingObserver {
  static late BerandaController instance;
  late BerandaView view;

  // State variables for restaurant data
  List<RestaurantLocation> restaurants = [];
  List<RestaurantLocation> filteredRestaurants = [];
  bool isLoading = false;
  String errorMessage = '';
  TextEditingController searchController = TextEditingController();

  // User location for distance calculation
  Position? userLocation;
  bool isLocationEnabled = false;

  // Filter states
  String selectedFilter = 'all'; // 'all', 'nearest'

  // Keep track of favorite states
  Map<String, bool> favoriteStates = {};

  // Last updated timestamp
  DateTime? lastUpdated;

  // Helper to check if nearest filter is showing no results due to location issues
  bool get isNearestFilterWithNoLocation =>
      selectedFilter == 'nearest' && userLocation == null;

  @override
  void initState() {
    instance = this;

    // Add this widget as an observer to lifecycle events
    WidgetsBinding.instance.addObserver(this);

    // Set listener for favorite changes
    FavoriteEventManager.setListener(() {
      refreshFavoriteStatesFromNavigation();
    });

    // Load restaurant data when controller initializes
    fetchRestaurants();

    // Get user location for distance calculation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getUserLocation().then((value) => _updateDistances());
    });

    // Add listener to search controller
    searchController.addListener(_onSearchChanged);

    super.initState();
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    WidgetsBinding.instance.removeObserver(this);

    // Clear favorite event listener
    FavoriteEventManager.clearListener();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // Refresh favorite states when app becomes active
    if (state == AppLifecycleState.resumed) {
      _refreshFavoriteStates();
    }
  }

  // Method to refresh favorite states
  Future<void> _refreshFavoriteStates() async {
    log('Refreshing favorite states...');
    await _loadFavoriteStates();
  }

  // Public method to refresh favorite states when returning from navigation
  Future<void> refreshFavoriteStatesFromNavigation() async {
    log('Refreshing favorite states from navigation...');
    await _loadFavoriteStates();
  }

  // Get user location for distance calculation
  Future<void> _getUserLocation() async {
    try {
      bool hasPermission = await LocationService.isLocationServiceEnabled();
      setState(() {
        isLocationEnabled = hasPermission;
      });

      if (hasPermission) {
        Position? position = await LocationService.getCurrentLocation();
        setState(() {
          userLocation = position;
        });

        // Update distances if we have restaurants loaded
        if (restaurants.isNotEmpty) {
          _updateDistances();
        }
      }
    } catch (e) {
      log('Error getting user location: $e');
    }
  }

  // Update distances for all restaurants
  void _updateDistances() {
    if (userLocation == null) return;

    setState(() {
      restaurants = restaurants.map((restaurant) {
        final distance = RestaurantService.calculateDistance(
          userLocation!.latitude,
          userLocation!.longitude,
          restaurant.latitude,
          restaurant.longitude,
        );
        return restaurant.copyWith(distance: distance);
      }).toList();

      // Apply current filter
      _applyFilter();
    });
    update();
  }

  // Apply current filter to restaurants
  void _applyFilter() {
    List<RestaurantLocation> baseList = restaurants;

    // Apply search filter if there's a query
    final query = searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      baseList = restaurants.where((restaurant) {
        final name = restaurant.name.toLowerCase();
        final city = restaurant.city.toLowerCase();
        final address = restaurant.address.toLowerCase();
        final description = restaurant.description?.toLowerCase() ?? '';

        return name.contains(query) ||
            city.contains(query) ||
            address.contains(query) ||
            description.contains(query);
      }).toList();
    }

    // Apply category filter
    if (selectedFilter == 'all') {
      // Show all restaurants (already filtered by search if applicable)
      log('Filter semua: Showing all ${baseList.length} restaurants');
    } else if (selectedFilter == 'nearest') {
      if (userLocation != null) {
        // Ensure all restaurants have distance calculated
        baseList = baseList.map((restaurant) {
          if (restaurant.distance == null) {
            final distance = RestaurantService.calculateDistance(
              userLocation!.latitude,
              userLocation!.longitude,
              restaurant.latitude,
              restaurant.longitude,
            );
            return restaurant.copyWith(distance: distance);
          }
          return restaurant;
        }).toList();

        // Sort by distance (nearest first)
        baseList.sort((a, b) => (a.distance ?? double.infinity)
            .compareTo(b.distance ?? double.infinity));

        // Take only restaurants within 20km (increased from 10km)
        baseList = baseList
            .where((restaurant) =>
                (restaurant.distance ?? double.infinity) <= 31.0)
            .toList();

        log('Filter terdekat: Found ${baseList.length} restaurants within 20km');
      } else {
        // If no location permission, keep the list but show message via different means
        // Don't set baseList = [] here as it causes UI to hide filter buttons
        log('Filter terdekat: No user location available - showing all restaurants');
      }
    }

    setState(() {
      filteredRestaurants = baseList;
    });

    log('Applied filter "$selectedFilter": ${filteredRestaurants.length} restaurants shown');
  }

  // Set filter category
  void setFilter(String filter) {
    log('Setting filter to: $filter');
    log('User location available: ${userLocation != null}');
    log('Location enabled: $isLocationEnabled');
    log('Total restaurants: ${restaurants.length}');

    setState(() {
      selectedFilter = filter;
    });
    _applyFilter();
  }

  // Debug method to check status
  void debugFilterStatus() {
    log('=== FILTER DEBUG STATUS ===');
    log('Selected filter: $selectedFilter');
    log('User location: ${userLocation != null ? "Available (${userLocation!.latitude}, ${userLocation!.longitude})" : "Not available"}');
    log('Location enabled: $isLocationEnabled');
    log('Total restaurants: ${restaurants.length}');
    log('Filtered restaurants: ${filteredRestaurants.length}');
    log('Search query: "${searchController.text}"');

    if (filteredRestaurants.isNotEmpty) {
      final first = filteredRestaurants.first;
      log('First restaurant: ${first.name} - Distance: ${first.distance?.toStringAsFixed(2) ?? "Unknown"} km');
    }
    log('==========================');
  }

  // Fetch restaurant list from Firebase
  Future<void> fetchRestaurants() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final List<RestaurantLocation> fetchedRestaurants =
          await RestaurantService.getAllRestaurants();

      setState(() {
        restaurants = fetchedRestaurants;
        isLoading = false;
        lastUpdated = DateTime.now(); // Update timestamp
      });

      // Calculate distances if user location is available
      if (userLocation != null) {
        _updateDistances();
      } else {
        // Apply filter without distance
        _applyFilter();
      }

      // Load favorite states for all restaurants
      await _loadFavoriteStates();
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });

      // Show error message to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $errorMessage'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  // Load favorite states for all restaurants
  Future<void> _loadFavoriteStates() async {
    for (final restaurant in restaurants) {
      final isFav = await FavoriteService.isFavorite(restaurant.id);
      favoriteStates[restaurant.id] = isFav;
    }
    if (mounted) setState(() {});
  }

  // Toggle favorite status
  Future<void> toggleFavorite(RestaurantLocation restaurant) async {
    try {
      final success = await FavoriteService.toggleFavorite(
        restaurantId: restaurant.id,
        restaurantName: restaurant.name,
        description: restaurant.description ??
            restaurant.address, // Use description or address as fallback
        city: restaurant.city,
        address: restaurant.address,
        pictureId: restaurant.pictureUrl, // Use pictureUrl as pictureId
        rating: restaurant.rating,
      );

      if (success) {
        final newState = !(favoriteStates[restaurant.id] ?? false);
        setState(() {
          favoriteStates[restaurant.id] = newState;
        });

        // Notify about favorite change (for other listening widgets)
        FavoriteEventManager.notifyFavoriteChanged();

        // Show feedback to user
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                newState
                    ? '${restaurant.name} ditambahkan ke favorit'
                    : '${restaurant.name} dihapus dari favorit',
              ),
              duration: const Duration(seconds: 2),
              backgroundColor: newState
                  ? Theme.of(context).colorScheme.primary
                  : Colors.orange,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  // Check if restaurant is favorite
  bool isFavorite(String restaurantId) {
    return favoriteStates[restaurantId] ?? false;
  }

  // Search restaurants locally only
  void _onSearchChanged() {
    _applyFilter();
  }

  // Refresh data (for pull-to-refresh)
  Future<void> refreshData() async {
    await fetchRestaurants();
  }

  // Format last updated time for display
  String formatLastUpdated() {
    if (lastUpdated == null) return '';

    final now = DateTime.now();
    final difference = now.difference(lastUpdated!);

    if (difference.inMinutes < 1) {
      return 'Baru saja';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m yang lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h yang lalu';
    } else {
      return '${difference.inDays}d yang lalu';
    }
  }

  // Clear search
  void clearSearch() {
    searchController.clear();
    setState(() {
      filteredRestaurants = restaurants;
    });
  }

  // Getter for current filter
  String get currentFilter => selectedFilter;

  // Debug helper method
  Map<String, dynamic> getDebugInfo() {
    return {
      'Filter': selectedFilter,
      'Location': userLocation != null ? 'Available' : 'Not Available',
      'Total Restaurants': restaurants.length,
      'Filtered Count': filteredRestaurants.length,
      'Location Enabled': isLocationEnabled,
      'Loading': isLoading,
    };
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
