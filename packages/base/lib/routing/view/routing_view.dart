import 'package:base/routing/controller/routing_controller.dart';
import 'package:core/core.dart'
    hide OpenRouteService, RouteInstruction, RouteSummary;
import 'package:flutter/material.dart';
import 'dart:ui';

class RoutingView extends StatefulWidget {
  final RestaurantLocation restaurant;
  final Position userLocation;

  const RoutingView({
    super.key,
    required this.restaurant,
    required this.userLocation,
  });

  Widget build(BuildContext context, RoutingController controller) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Petunjuk Arah',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        actions: [
          PopupMenuButton<String>(
            iconColor: Theme.of(context).colorScheme.onSurface,
            onSelected: controller.changeTransportMode,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'driving-car',
                child: Row(
                  children: [
                    Icon(
                      Icons.directions_car,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(width: 8),
                    const Text('Mobil'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'driving-hgv',
                child: Row(
                  children: [
                    Icon(
                      Icons.motorcycle,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(width: 8),
                    const Text('Motor'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'foot-walking',
                child: Row(
                  children: [
                    Icon(
                      Icons.directions_walk,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(width: 8),
                    const Text('Jalan Kaki'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'cycling-regular',
                child: Row(
                  children: [
                    Icon(
                      Icons.directions_bike,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(width: 8),
                    const Text('Sepeda'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          // Map area - mengisi seluruh layar
          controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : _buildMap(context, controller),

          // Route summary card - mengambang di atas
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: SafeArea(
              child: _buildRouteSummaryCard(context, controller),
            ),
          ),

          // Bottom bar - mengambang di bawah
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: _buildBottomBar(context, controller),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteSummaryCard(
      BuildContext context, RoutingController controller) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Destination info
              Row(
                children: [
                  Icon(
                    Icons.restaurant,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      restaurant.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${restaurant.address}, ${restaurant.city}',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12),

              // Route summary
              if (controller.routeSummary != null) ...[
                Row(
                  children: [
                    _buildSummaryItem(
                      context,
                      icon: Icons.straighten,
                      label: 'Jarak',
                      value: controller.routeSummary!.distanceText,
                    ),
                    const SizedBox(width: 16),
                    _buildSummaryItem(
                      context,
                      icon: Icons.schedule,
                      label: 'Waktu',
                      value: controller.routeSummary!.durationText,
                    ),
                    const SizedBox(width: 16),
                    _buildSummaryItem(
                      context,
                      icon: _getTransportIcon(controller.currentTransportMode),
                      label: 'Mode',
                      value:
                          _getTransportLabel(controller.currentTransportMode),
                    ),
                  ],
                ),
              ] else if (controller.hasError) ...[
                Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Theme.of(context).colorScheme.error,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Gagal memuat rute',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 18,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMap(BuildContext context, RoutingController controller) {
    return ClipRRect(
      borderRadius: BorderRadius.zero,
      child: FlutterMap(
        mapController: controller.mapController,
        options: MapOptions(
          initialCenter: LatLng(
            userLocation.latitude,
            userLocation.longitude,
          ),
          initialZoom: 13.0,
          maxZoom: 18.0,
          minZoom: 5.0,
          onMapReady: controller.onMapReady,
        ),
        children: [
          // Map tiles
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.lokamakan',
            maxZoom: 19,
          ),

          // Route polyline
          if (controller.routeCoordinates.isNotEmpty)
            PolylineLayer(
              polylines: [
                Polyline(
                  points: controller.routeCoordinates,
                  strokeWidth: 4.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),

          // Markers
          MarkerLayer(
            markers: [
              // Start marker (user location)
              Marker(
                point: LatLng(userLocation.latitude, userLocation.longitude),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.surface,
                      width: 3,
                    ),
                  ),
                  child: Icon(
                    Icons.my_location,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 20,
                  ),
                ),
              ),

              // Destination marker (restaurant)
              Marker(
                point: LatLng(
                  restaurant.location.latitude,
                  restaurant.location.longitude,
                ),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.error,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.surface,
                      width: 3,
                    ),
                  ),
                  child: Icon(
                    Icons.restaurant,
                    color: Theme.of(context).colorScheme.onError,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, RoutingController controller) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: SafeArea(
            child: IntrinsicHeight(
              child: Row(
                children: [
                  // Show instructions button
                  Expanded(
                    child: BaseSecondaryButton(
                      onPressed: () => _showInstructions(context, controller),
                      prefixIcon: const Icon(Icons.list),
                      text: 'Lihat Instruksi',
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Start navigation button
                  Expanded(
                    child: BasePrimaryButton(
                      onPressed: controller.routeCoordinates.isNotEmpty
                          ? () => controller.openInGoogleMaps()
                          : null,
                      prefixIcon: const Icon(Icons.navigation),
                      text: 'Mulai Navigasi',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showInstructions(BuildContext context, RoutingController controller) {
    if (controller.routeInstructions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Instruksi rute belum tersedia'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    'Instruksi Navigasi',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),

            // Instructions list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.routeInstructions.length,
                itemBuilder: (context, index) {
                  final instruction = controller.routeInstructions[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        instruction.instruction,
                        style: const TextStyle(fontSize: 14),
                      ),
                      subtitle: Text(
                        '${instruction.formattedDistance} • ${instruction.name}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getTransportIcon(String mode) {
    switch (mode) {
      case 'driving-car':
        return Icons.directions_car;
      case 'driving-hgv':
        return Icons.motorcycle;
      case 'foot-walking':
        return Icons.directions_walk;
      case 'cycling-regular':
        return Icons.directions_bike;
      default:
        return Icons.directions;
    }
  }

  String _getTransportLabel(String mode) {
    switch (mode) {
      case 'driving-car':
        return 'Mobil';
      case 'driving-hgv':
        return 'Motor';
      case 'foot-walking':
        return 'Jalan';
      case 'cycling-regular':
        return 'Sepeda';
      default:
        return 'Lainnya';
    }
  }

  @override
  State<RoutingView> createState() => RoutingController();
}
