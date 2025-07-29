import 'package:base/map_lbs/controller/map_lbs_controller.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart' hide RefreshIndicator;

class MapLbsView extends StatefulWidget {
  const MapLbsView({super.key});

  @override
  State<MapLbsView> createState() => MapLbsController();

  Widget build(BuildContext context, MapLbsController controller) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Restoran Terdekat'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              controller.showMap ? Icons.list : Icons.map,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: controller.toggleViewMode,
            tooltip: controller.showMap ? 'Tampilan List' : 'Tampilan Map',
          ),
          PopupMenuButton<double>(
            icon: Icon(
              Icons.tune,
              color: Theme.of(context).primaryColor,
            ),
            onSelected: controller.updateSearchRadius,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1.0,
                child: Text('1 km'),
              ),
              const PopupMenuItem(
                value: 3.0,
                child: Text('3 km'),
              ),
              const PopupMenuItem(
                value: 5.0,
                child: Text('5 km'),
              ),
              const PopupMenuItem(
                value: 10.0,
                child: Text('10 km'),
              ),
              const PopupMenuItem(
                value: 20.0,
                child: Text('20 km'),
              ),
            ],
          ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryColor,
            ),
            onSelected: (value) {
              if (value == 'setup_data') {
                controller.setupSampleData();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'setup_data',
                child: Row(
                  children: [
                    Icon(Icons.add_business),
                    SizedBox(width: 8),
                    Text('Setup Sample Data'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Material(
        child: RefreshIndicator(
          onRefresh: controller.refreshData,
          child: _buildBody(context, controller),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, MapLbsController controller) {
    if (controller.isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Mencari restoran terdekat...'),
          ],
        ),
      );
    }

    if (!controller.isLocationEnabled) {
      return _buildLocationPermissionView(context, controller);
    }

    if (controller.errorMessage.isNotEmpty) {
      return _buildErrorView(context, controller);
    }

    if (controller.nearbyRestaurants.isEmpty) {
      return _buildEmptyView(context, controller);
    }

    return Column(
      children: [
        _buildLocationInfo(context, controller),
        Expanded(
          child: controller.showMap
              ? _buildMapView(context, controller)
              : _buildListView(context, controller),
        ),
      ],
    );
  }

  Widget _buildLocationPermissionView(
      BuildContext context, MapLbsController controller) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_off,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 24),
            const Text(
              'Izin Lokasi Diperlukan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Aplikasi memerlukan akses lokasi untuk menampilkan restoran terdekat dengan Anda.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: controller.requestLocationPermission,
              icon: const Icon(Icons.location_on),
              label: const Text('Berikan Izin Lokasi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: controller.openLocationSettings,
              child: const Text('Buka Pengaturan Lokasi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, MapLbsController controller) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red[400],
            ),
            const SizedBox(height: 24),
            const Text(
              'Terjadi Kesalahan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              controller.errorMessage,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: controller.refreshData,
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyView(BuildContext context, MapLbsController controller) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 24),
            const Text(
              'Tidak Ada Restoran Terdekat',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Tidak ada restoran dalam radius ${controller.searchRadius.toStringAsFixed(0)} km dari lokasi Anda.',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => controller.updateSearchRadius(20.0),
              child: const Text('Perluas Pencarian ke 20km'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationInfo(BuildContext context, MapLbsController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.my_location,
                size: 16,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                'Lokasi Anda: ${controller.userLocationText}',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.restaurant,
                size: 16,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 8),
              Text(
                '${controller.nearbyRestaurants.length} restoran dalam radius ${controller.searchRadius.toStringAsFixed(0)} km',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMapView(BuildContext context, MapLbsController controller) {
    // For now, show a placeholder - you can integrate with Google Maps later
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.map,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'Map View',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Integrasi Google Maps akan ditambahkan di sini',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context, MapLbsController controller) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: controller.nearbyRestaurants.length,
      itemBuilder: (context, index) {
        final restaurant = controller.nearbyRestaurants[index];
        return Column(
          children: [
            _buildRestaurantCard(context, restaurant),
            const SizedBox(height: 12),
          ],
        );
      },
    );
  }

  Widget _buildRestaurantCard(
      BuildContext context, RestaurantLocation restaurant) {
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
            RestaurantCardImage(
              imageUrl: restaurant.pictureUrl,
              size: 60,
            ),
            const SizedBox(width: 12),

            // Restaurant Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
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
                          restaurant.address,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (restaurant.rating != null) ...[
                        const Icon(
                          Icons.star,
                          size: 14,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          restaurant.rating!.toStringAsFixed(1),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Icon(
                        Icons.directions_walk,
                        size: 14,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        LocationService.formatDistance(restaurant.distance),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Action buttons
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    // TODO: Navigate to restaurant detail
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Detail ${restaurant.name}'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.info_outline),
                  iconSize: 20,
                ),
                IconButton(
                  onPressed: () {
                    // TODO: Open directions in map app
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Arah ke ${restaurant.name}'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.directions),
                  iconSize: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
