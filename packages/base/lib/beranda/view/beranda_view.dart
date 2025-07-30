import 'package:base/beranda/controller/beranda_controller.dart';
import 'package:base/favorites/view/favorites_view.dart';
import 'package:base/restaurant_detail/view/restaurant_detail_view.dart';
import 'package:core/core.dart' hide RefreshIndicator;
import 'package:flutter/material.dart';

class BerandaView extends StatefulWidget {
  const BerandaView({super.key});

  Widget build(BuildContext context, BerandaController controller) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: BaseAppDrawer.beranda(
        onAdminRestaurantTap: () {
          newRouter.push(RouterUtils.adminRestaurant);
        },
      ),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: innerBoxIsScrolled
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
                title: Text(
                  'Restoran',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: innerBoxIsScrolled
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                actions: [
                  // Refresh button
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    color: innerBoxIsScrolled
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                    onPressed: controller.refreshData,
                    tooltip: 'Refresh Data',
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_sharp),
                    color: innerBoxIsScrolled
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                    onPressed: () {
                      Get.to(const FavoritesView());
                    },
                    tooltip: 'Refresh Data',
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                ],
                backgroundColor: Theme.of(context).colorScheme.primary,
                elevation: 0,
                iconTheme: IconThemeData(
                    color: Theme.of(context).colorScheme.onPrimary),
                floating: true,
                snap: true,
                pinned: true,
                expandedHeight: 184.0,
                collapsedHeight: 60.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: Theme.of(context).colorScheme.surface,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                          top: 60.0,
                        ),
                        child: Column(
                          children: [
                            BaseForm(
                              textEditingController:
                                  controller.searchController,
                              hintText: 'Cari Restoran',
                              prefixIcon: Icon(
                                Icons.search,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: controller.currentFilter == 'all'
                                      ? BasePrimaryButton(
                                          onPressed: () =>
                                              controller.setFilter('all'),
                                          text: 'Semua',
                                        )
                                      : BaseSecondaryButton(
                                          onPressed: () =>
                                              controller.setFilter('all'),
                                          text: 'Semua',
                                        ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: controller.currentFilter == 'nearest'
                                      ? BasePrimaryButton(
                                          onPressed: () =>
                                              controller.setFilter('nearest'),
                                          text: 'Terdekat',
                                        )
                                      : BaseSecondaryButton(
                                          onPressed: () =>
                                              controller.setFilter('nearest'),
                                          text: 'Terdekat',
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: RefreshIndicator(
            onRefresh: controller.refreshData,
            child: controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.filteredRestaurants.isEmpty
                    ? SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: const Center(
                            child: Text(
                              'Tidak ada restoran ditemukan',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16.0),
                        itemCount: controller.filteredRestaurants.length +
                            1, // +1 for header
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            // Header section
                            return controller.searchController.text.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Hasil Pencarian "${controller.searchController.text}"',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                              ),
                                            ),
                                          ),
                                          // Last updated info
                                          if (controller.lastUpdated != null)
                                            Text(
                                              'Update: ${controller.formatLastUpdated()}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  )
                                : Container(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Daftar Restoran (${controller.filteredRestaurants.length})',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                        ),
                                        // Last updated info
                                        if (controller.lastUpdated != null)
                                          Text(
                                            'Update: ${controller.formatLastUpdated()}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                      ],
                                    ),
                                  );
                          }

                          // Restaurant card
                          final restaurant =
                              controller.filteredRestaurants[index - 1];
                          return Column(
                            children: [
                              BaseRestaurantCard.withFavorite(
                                restaurant: restaurant,
                                isFavorite:
                                    controller.isFavorite(restaurant.id),
                                onFavoriteToggle: () async {
                                  await controller.toggleFavorite(restaurant);
                                },
                                showDistance: true,
                                onTap: () {
                                  Get.to(RestaurantDetailView(
                                      restaurant: restaurant));
                                },
                              ),
                              const SizedBox(height: 12),
                            ],
                          );
                        },
                      ),
          ),
        ),
      ),
    );
  }

  @override
  State<BerandaView> createState() => BerandaController();
}
