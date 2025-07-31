import 'package:base/restaurant_detail/controller/restaurant_detail_controller.dart';
import 'package:base/restaurant_detail/widgets/menu_widgets.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class RestaurantDetailView extends StatefulWidget {
  final RestaurantLocation restaurant;

  const RestaurantDetailView({
    super.key,
    required this.restaurant,
  });

  Widget build(BuildContext context, RestaurantDetailController controller) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leadingWidth: 64,
            leading: Container(
              margin: const EdgeInsets.only(left: 16, top: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 24,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            expandedHeight: 300.0,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.surface,
            iconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: _buildRestaurantImage(context),
            ),
            actions: [
              // Favorite button
              Container(
                margin: const EdgeInsets.only(right: 16, top: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  onPressed: () async {
                    await controller.toggleFavorite();
                  },
                  icon: Icon(
                    controller.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: controller.isFavorite
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Restaurant name and rating
                  _buildRestaurantHeader(context),
                  const SizedBox(height: 16),

                  // Location and distance info
                  _buildLocationInfo(context, controller),
                  const SizedBox(height: 24),

                  // Description
                  if (restaurant.description?.isNotEmpty == true) ...[
                    _buildSectionTitle(context, 'Deskripsi'),
                    const SizedBox(height: 8),
                    Text(
                      restaurant.description!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Location Based Service Actions
                  _buildLBSActions(context, controller),
                  const SizedBox(height: 24),

                  // Quick Info Cards
                  _buildQuickInfoCards(context, controller),
                  const SizedBox(height: 24),

                  // Restaurant Menu Section
                  if (controller.restaurantMenu != null) ...[
                    RestaurantMenuSection(
                      menu: controller.restaurantMenu!,
                      selectedCategoryId: controller.selectedCategoryId,
                      onCategorySelected: controller.selectMenuCategory,
                      onMenuItemTap: (item) {
                        _showMenuItemDetail(context, item);
                      },
                    ),
                    const SizedBox(height: 24),
                  ] else if (controller.isMenuLoading) ...[
                    _buildSectionTitle(context, 'Menu'),
                    const SizedBox(height: 16),
                    const Center(child: CircularProgressIndicator()),
                    const SizedBox(height: 24),
                  ] else ...[
                    _buildSectionTitle(context, 'Menu'),
                    const SizedBox(height: 16),
                    _buildNoMenuAvailable(context),
                    const SizedBox(height: 24),
                  ],

                  // Map integration (jika user location available)
                  if (controller.userLocation != null)
                    _buildMapSection(context, controller),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantImage(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
      child: Image.network(
        restaurant.pictureUrl!,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
              strokeWidth: 2,
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildImagePlaceholder(context);
        },
      ),
    );
  }

  Widget _buildImagePlaceholder(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.restaurant,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 8),
          Text(
            'Foto Restoran',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          restaurant.name,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.star,
              size: 20,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            const SizedBox(width: 4),
            Text(
              restaurant.rating?.toStringAsFixed(1) ?? 'N/A',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '• Restaurant',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationInfo(
      BuildContext context, RestaurantDetailController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${restaurant.address}, ${restaurant.city}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          if (controller.distance != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.directions_walk,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  LocationService.formatDistance(controller.distance),
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  ' dari lokasi Anda',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
    );
  }

  Widget _buildLBSActions(
      BuildContext context, RestaurantDetailController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Navigasi & Lokasi'),
        const SizedBox(height: 12),
        BasePrimaryButton(
          onPressed: controller.userLocation != null
              ? () => controller.openDirections()
              : null,
          suffixIcon: const Icon(Icons.directions),
          text: 'Petunjuk Arah',
        ),
      ],
    );
  }

  Widget _buildQuickInfoCards(
      BuildContext context, RestaurantDetailController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Informasi'),
        const SizedBox(height: 12),
        Row(
          children: [
            // Distance card
            if (controller.distance != null)
              Expanded(
                child: _buildInfoCard(
                  context,
                  icon: Icons.directions_walk,
                  title: 'Jarak',
                  value: LocationService.formatDistance(controller.distance),
                ),
              ),
            if (controller.distance != null) const SizedBox(width: 12),

            // Rating card
            Expanded(
              child: _buildInfoCard(
                context,
                icon: Icons.star,
                title: 'Rating',
                value: restaurant.rating?.toStringAsFixed(1) ?? 'N/A',
              ),
            ),
            const SizedBox(width: 12),

            // City card
            Expanded(
              child: _buildInfoCard(
                context,
                icon: Icons.location_city,
                title: 'Kota',
                value: restaurant.city,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
          const SizedBox(height: 4),
          Text(
            title,
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

  Widget _buildMapSection(
      BuildContext context, RestaurantDetailController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Lokasi di Peta'),
        const SizedBox(height: 12),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(
                      restaurant.location.latitude,
                      restaurant.location.longitude,
                    ),
                    initialZoom: 15.0,
                    maxZoom: 18.0,
                    minZoom: 5.0,
                    interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                    ),
                  ),
                  children: [
                    // Map tiles
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.lokamakan',
                      maxZoom: 19,
                    ),

                    // Markers
                    MarkerLayer(
                      markers: [
                        // Restaurant marker
                        Marker(
                          point: LatLng(
                            restaurant.location.latitude,
                            restaurant.location.longitude,
                          ),
                          width: 80,
                          height: 80,
                          child: Column(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.error,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.restaurant,
                                  color: Theme.of(context).colorScheme.onError,
                                  size: 20,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .outline
                                        .withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  restaurant.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // User location marker (if available)
                        if (controller.userLocation != null)
                          Marker(
                            point: LatLng(
                              controller.userLocation!.latitude,
                              controller.userLocation!.longitude,
                            ),
                            width: 40,
                            height: 40,
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
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.my_location,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 16,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),

                // Overlay buttons
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Column(
                    children: [
                      // Open in external maps button
                      FloatingActionButton.small(
                        heroTag: "external_maps",
                        onPressed: () => controller.openInMaps(),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        child: const Icon(Icons.open_in_new, size: 16),
                      ),
                      if (controller.userLocation != null) ...[
                        const SizedBox(height: 8),
                        // Directions button
                        FloatingActionButton.small(
                          heroTag: "directions_maps",
                          onPressed: () => controller.openDirections(),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onSecondary,
                          child: const Icon(Icons.directions, size: 16),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showMenuItemDetail(BuildContext context, MenuItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant
                      .withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Menu image
                      if (item.imageUrl != null) ...[
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).colorScheme.surfaceVariant,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              item.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return _buildMenuImagePlaceholder(context);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Menu name
                      Text(
                        item.name,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                      const SizedBox(height: 8),

                      // Price and cooking time
                      Row(
                        children: [
                          Text(
                            item.formattedPrice,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          const Spacer(),
                          if (item.cookingTime != null) ...[
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              item.cookingTime!,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                            ),
                          ],
                        ],
                      ),

                      // Tags
                      if (item.tags.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: item.tags
                              .map((tag) => _buildDetailTag(context, tag))
                              .toList(),
                        ),
                      ],

                      // Description
                      if (item.description != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          'Deskripsi',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.description!,
                          style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            height: 1.5,
                          ),
                        ),
                      ],

                      // Ingredients
                      if (item.ingredients != null &&
                          item.ingredients!.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text(
                          'Bahan-bahan',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: item.ingredients!
                              .map((ingredient) => Chip(
                                    label: Text(ingredient),
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .surfaceVariant,
                                    side: BorderSide.none,
                                  ))
                              .toList(),
                        ),
                      ],

                      // Allergens
                      if (item.allergens != null &&
                          item.allergens!.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text(
                          'Alergen',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.allergens!.join(', '),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ],

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuImagePlaceholder(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.restaurant_menu,
            size: 48,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 8),
          Text(
            'Foto Menu',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailTag(BuildContext context, String tag) {
    Color backgroundColor;
    Color textColor;

    switch (tag.toLowerCase()) {
      case 'vegan':
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green.shade700;
        break;
      case 'vegetarian':
        backgroundColor = Colors.lightGreen.withOpacity(0.1);
        textColor = Colors.lightGreen.shade700;
        break;
      case 'halal':
        backgroundColor = Colors.blue.withOpacity(0.1);
        textColor = Colors.blue.shade700;
        break;
      case 'pedas':
        backgroundColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red.shade700;
        break;
      case 'tidak tersedia':
        backgroundColor = Theme.of(context).colorScheme.errorContainer;
        textColor = Theme.of(context).colorScheme.onErrorContainer;
        break;
      default:
        backgroundColor = Theme.of(context).colorScheme.surfaceVariant;
        textColor = Theme.of(context).colorScheme.onSurfaceVariant;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        tag,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Widget _buildNoMenuAvailable(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.restaurant_menu_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'Menu Belum Tersedia',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Restoran ini belum menambahkan menu. Silakan hubungi restoran langsung untuk informasi menu dan harga.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<RestaurantDetailView> createState() => RestaurantDetailController();
}
