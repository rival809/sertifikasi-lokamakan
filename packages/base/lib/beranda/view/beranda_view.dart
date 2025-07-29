import 'package:base/beranda/controller/beranda_controller.dart';
import 'package:base/favorites/view/favorites_view.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class BerandaView extends StatefulWidget {
  const BerandaView({super.key});

  Widget build(BuildContext context, BerandaController controller) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: BaseAppDrawer.beranda(
        onRestaurantListTap: () {},
        onFavoriteTap: () {
          Get.to(const FavoritesView());
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: controller.currentFilter == 'all'
                    ? BasePrimaryButton(
                        onPressed: () => controller.setFilter('all'),
                        text: 'Semua',
                      )
                    : BaseSecondaryButton(
                        onPressed: () => controller.setFilter('all'),
                        text: 'Semua',
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: controller.currentFilter == 'nearest'
                    ? BasePrimaryButton(
                        onPressed: () => controller.setFilter('nearest'),
                        text: 'Terdekat',
                      )
                    : BaseSecondaryButton(
                        onPressed: () => controller.setFilter('nearest'),
                        text: 'Terdekat',
                      ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
                title: Text(
                  'Restoran',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                backgroundColor: Theme.of(context).colorScheme.surface,
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.black),
                floating: true,
                snap: true,
                pinned: true,
                expandedHeight: 120.0,
                collapsedHeight: 60.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: Theme.of(context).colorScheme.surface,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                          top: 52.0, // Account for AppBar height
                          bottom: 16.0,
                        ),
                        child: BaseForm(
                          textEditingController: controller.searchController,
                          hintText: 'Cari Restoran',
                          prefixIcon: Icon(
                            Icons.search,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.filteredRestaurants.isEmpty
                  ? const Center(
                      child: Text(
                        'Tidak ada restoran ditemukan',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: controller.filteredRestaurants.length +
                          1, // +1 for header
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          // Header section
                          return controller.searchController.text.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hasil Pencarian "${controller.searchController.text}"',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                )
                              : const SizedBox.shrink();
                        }

                        // Restaurant card
                        final restaurant =
                            controller.filteredRestaurants[index - 1];
                        return Column(
                          children: [
                            BaseRestaurantCard.withFavorite(
                              restaurant: restaurant,
                              isFavorite: controller.isFavorite(restaurant.id),
                              onFavoriteToggle: () async {
                                await controller.toggleFavorite(restaurant);
                              },
                              showDistance: true,
                              onTap: () {
                                // TODO: Navigate to restaurant detail
                              },
                            ),
                            const SizedBox(height: 12),
                          ],
                        );
                      },
                    ),
        ),
      ),
    );
  }

  @override
  State<BerandaView> createState() => BerandaController();
}
