import 'package:base/map_lbs/view/map_lbs_view.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:developer';

class MapLbsController extends State<MapLbsView> {
  static late MapLbsController instance;
  late MapLbsView view;

  // Location and restaurant data
  Position? userLocation;
  List<RestaurantLocation> nearbyRestaurants = [];
  bool isLoading = false;
  bool isLocationEnabled = false;
  String errorMessage = '';
  double searchRadius = 5.0; // Default 5km radius

  // UI state
  bool showMap = true; // Toggle between map and list view
  bool showPermissionDialog = false;

  @override
  void initState() {
    instance = this;
    checkLocationPermissionAndLoad();
    super.initState();
  }

  /// Check location permission and load data
  Future<void> checkLocationPermissionAndLoad() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      bool hasPermission = await LocationService.isLocationServiceEnabled();
      setState(() {
        isLocationEnabled = hasPermission;
      });

      if (hasPermission) {
        await loadUserLocationAndRestaurants();
      } else {
        setState(() {
          isLoading = false;
          errorMessage =
              'Izin lokasi diperlukan untuk menampilkan restoran terdekat';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error: ${e.toString()}';
      });
    }
  }

  /// Load user location and nearby restaurants
  Future<void> loadUserLocationAndRestaurants() async {
    try {
      // Get user location
      Position? position = await LocationService.getCurrentLocation();
      setState(() {
        userLocation = position;
      });

      if (position != null) {
        await loadNearbyRestaurants();
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Tidak dapat mendapatkan lokasi Anda';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error loading location: ${e.toString()}';
      });
    }
  }

  /// Load nearby restaurants from Firebase
  Future<void> loadNearbyRestaurants() async {
    if (userLocation == null) return;

    try {
      setState(() {
        isLoading = true;
      });

      // Get restaurants from Firebase
      List<RestaurantLocation> restaurants =
          await RestaurantService.getNearbyRestaurants(
        userLatitude: userLocation!.latitude,
        userLongitude: userLocation!.longitude,
        radiusKm: searchRadius,
      );

      setState(() {
        nearbyRestaurants = restaurants;
        isLoading = false;
      });

      log('Loaded ${restaurants.length} restaurants from Firebase');
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error loading restaurants: ${e.toString()}';
      });
      log('Error loading restaurants: $e');
    }
  }

  /// Request location permission
  Future<void> requestLocationPermission() async {
    try {
      LocationPermission permission =
          await LocationService.requestLocationPermission();

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        await checkLocationPermissionAndLoad();
      } else if (permission == LocationPermission.deniedForever) {
        setState(() {
          showPermissionDialog = true;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error requesting permission: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  /// Open location settings
  Future<void> openLocationSettings() async {
    await LocationService.openLocationSettings();
  }

  /// Open app settings
  Future<void> openAppSettings() async {
    await LocationService.openAppSettings();
  }

  /// Toggle between map and list view
  void toggleViewMode() {
    setState(() {
      showMap = !showMap;
    });
  }

  /// Update search radius
  void updateSearchRadius(double radius) {
    setState(() {
      searchRadius = radius;
    });
    loadNearbyRestaurants();
  }

  /// Refresh data
  Future<void> refreshData() async {
    await checkLocationPermissionAndLoad();
  }

  /// Setup sample data to Firebase (for testing purposes)
  Future<void> setupSampleData() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      // Sample restaurants data with GeoPoint
      final List<Map<String, dynamic>> sampleRestaurants = [
        {
          'name': 'Warung Padang Sederhana',
          'location': const GeoPoint(-6.8571, 107.9207),
          'address': 'Jl. Mayor Abdurahman No. 123, Sumedang',
          'city': 'Sumedang',
          'rating': 4.5,
          'pictureUrl':
              'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800&auto=format&fit=crop',
          'description': 'Warung Padang dengan cita rasa autentik',
          'isActive': true,
          'createdAt': FieldValue.serverTimestamp(),
        },
        {
          'name': 'Sate Ayam Pak Haji',
          'location': const GeoPoint(-6.8522, 107.9156),
          'address': 'Jl. Prabu Geusan Ulun No. 45, Sumedang',
          'city': 'Sumedang',
          'rating': 4.3,
          'pictureUrl':
              'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800&auto=format&fit=crop',
          'description': 'Sate ayam bakar dengan bumbu kacang spesial',
          'isActive': true,
          'createdAt': FieldValue.serverTimestamp(),
        },
        {
          'name': 'Tahu Sumedang Asli',
          'location': const GeoPoint(-6.8580, 107.9200),
          'address': 'Jl. Pasar Sumedang No. 12, Sumedang',
          'city': 'Sumedang',
          'rating': 4.8,
          'pictureUrl':
              'https://images.unsplash.com/photo-1565958011703-44f9829ba187?w=800&auto=format&fit=crop',
          'description': 'Tahu Sumedang goreng dan isi original',
          'isActive': true,
          'createdAt': FieldValue.serverTimestamp(),
        },
      ];

      // Add to Firestore
      final batch = FirebaseFirestore.instance.batch();
      for (final restaurant in sampleRestaurants) {
        final docRef = FirebaseFirestore.instance.collection('resto').doc();
        batch.set(docRef, restaurant);
      }

      await batch.commit();
      log('Sample data added to Firebase');

      // Reload data after adding
      await loadNearbyRestaurants();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                const Text('Sample data berhasil ditambahkan ke Firebase!'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error setting up sample data: ${e.toString()}';
      });

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

  /// Get formatted user location
  String get userLocationText {
    if (userLocation == null) return 'Lokasi tidak tersedia';
    return 'Lat: ${userLocation!.latitude.toStringAsFixed(4)}, Lng: ${userLocation!.longitude.toStringAsFixed(4)}';
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
