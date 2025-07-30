import 'package:base/routing/view/routing_view.dart';
import 'package:base/services/openroute_service.dart';
import 'package:core/core.dart'
    hide OpenRouteService, RouteInstruction, RouteSummary;
import 'package:flutter/material.dart';

class RoutingController extends State<RoutingView> {
  late RestaurantLocation restaurant;
  late Position userLocation;

  MapController mapController = MapController();
  bool isLoading = true;
  bool hasError = false;
  bool isDarkMode = false;
  String currentTransportMode = 'driving-hgv'; // Default ke sepeda motor
  bool isMapReady = false;

  RouteSummary? routeSummary;
  List<LatLng> routeCoordinates = [];
  List<RouteInstruction> routeInstructions = [];

  @override
  void initState() {
    super.initState();
    restaurant = widget.restaurant;
    userLocation = widget.userLocation;
    _loadRoute();
  }

  Future<void> _loadRoute() async {
    isLoading = true;
    hasError = false;
    update();

    try {
      final startPoint = LatLng(userLocation.latitude, userLocation.longitude);
      final endPoint =
          LatLng(restaurant.location.latitude, restaurant.location.longitude);

      // Get route data
      final routeResponse = await OpenRouteService.getDirections(
        start: startPoint,
        end: endPoint,
        profile: currentTransportMode,
      );

      routeCoordinates = routeResponse.coordinates;
      routeInstructions = routeResponse.instructions;

      routeSummary = RouteSummary(
        distance: routeResponse.summary.distance,
        duration: routeResponse.summary.duration,
        distanceText: _formatDistance(routeResponse.summary.distance),
        durationText: _formatDuration(routeResponse.summary.duration),
      );

      // Fit map to show entire route after map is ready
      if (isMapReady) {
        _fitMapToRoute();
      }
    } catch (e) {
      debugPrint('Error loading route: $e');
      hasError = true;
      update();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memuat rute: ${e.toString()}'),
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: 'Coba Lagi',
              onPressed: _loadRoute,
            ),
          ),
        );
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  void _fitMapToRoute() {
    if (routeCoordinates.isEmpty || !isMapReady) return;

    try {
      // Calculate bounds
      double minLat = routeCoordinates.first.latitude;
      double maxLat = routeCoordinates.first.latitude;
      double minLng = routeCoordinates.first.longitude;
      double maxLng = routeCoordinates.first.longitude;

      for (final point in routeCoordinates) {
        minLat = minLat < point.latitude ? minLat : point.latitude;
        maxLat = maxLat > point.latitude ? maxLat : point.latitude;
        minLng = minLng < point.longitude ? minLng : point.longitude;
        maxLng = maxLng > point.longitude ? maxLng : point.longitude;
      }

      // Add padding
      const padding = 0.01;
      final bounds = LatLngBounds(
        LatLng(minLat - padding, minLng - padding),
        LatLng(maxLat + padding, maxLng + padding),
      );

      // Fit map to bounds with a small delay to ensure map is fully ready
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted && isMapReady) {
          mapController.fitCamera(
            CameraFit.bounds(
              bounds: bounds,
              padding: const EdgeInsets.all(50),
            ),
          );
        }
      });
    } catch (e) {
      debugPrint('Error fitting map to route: $e');
    }
  }

  void onMapReady() {
    isMapReady = true;
    update();

    // If route is already loaded, fit the map
    if (routeCoordinates.isNotEmpty) {
      _fitMapToRoute();
    }
  }

  void switchMapStyle() {
    isDarkMode = !isDarkMode;
    update();
  }

  void changeTransportMode(String mode) {
    if (mode != currentTransportMode) {
      currentTransportMode = mode;
      update();
      _loadRoute();
    }
  }

  Future<void> openInGoogleMaps() async {
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
      debugPrint('Error opening Google Maps: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal membuka Google Maps'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  String _formatDistance(double distanceKm) {
    if (distanceKm < 1) {
      return '${(distanceKm * 1000).round()} m';
    }
    return '${distanceKm.toStringAsFixed(1)} km';
  }

  String _formatDuration(double durationSeconds) {
    final hours = (durationSeconds / 3600).floor();
    final minutes = ((durationSeconds % 3600) / 60).floor();

    if (hours > 0) {
      return '$hours jam $minutes menit';
    }
    return '$minutes menit';
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, this);
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}
