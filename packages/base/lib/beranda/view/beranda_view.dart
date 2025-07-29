import 'package:base/beranda/controller/beranda_controller.dart';
import 'package:base/models/detail_restaurant_model.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class BerandaView extends StatefulWidget {
  const BerandaView({super.key});

  Widget build(BuildContext context, BerandaController controller) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: _buildDrawer(context, controller),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: const Text(
                  'Restoran',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                backgroundColor: Theme.of(context).colorScheme.surface,
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.black),
                floating: true,
                snap: true,
                pinned: true, // Keeps the AppBar title always visible
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
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.searchController.text.isNotEmpty
                                    ? 'Hasil Pencarian "${controller.searchController.text}"'
                                    : 'Restaurants Nearby',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          );
                        }

                        // Restaurant card
                        final restaurant =
                            controller.filteredRestaurants[index - 1];
                        return Column(
                          children: [
                            _buildRestaurantCard(
                              context: context,
                              restaurant: restaurant,
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

  Widget _buildRestaurantCard({
    required BuildContext context,
    required Restaurant restaurant,
  }) {
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
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  image: restaurant.pictureId != null
                      ? DecorationImage(
                          image: NetworkImage(
                            'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                          ),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: restaurant.pictureId == null
                    ? const Icon(
                        Icons.restaurant,
                        color: Colors.grey,
                        size: 30,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 12),

            // Restaurant Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name ?? 'Unknown Restaurant',
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
                          restaurant.city ?? 'Unknown City',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        restaurant.rating?.toStringAsFixed(1) ?? 'N/A',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          restaurant.description ?? 'No description',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, BerandaController controller) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.8),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 35,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  SessionService.currentUserData?.displayName ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  SessionService.currentUserData?.email ?? "",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Beranda'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.restaurant_outlined),
            title: const Text('Daftar Restoran'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to restaurant list
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite_outline),
            title: const Text('Favorit'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to favorites
            },
          ),
          ListTile(
            leading: const Icon(Icons.history_outlined),
            title: const Text('Riwayat'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to history
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.location_on_outlined),
            title: const Text('Lokasi Saya'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to location settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Pengaturan'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Bantuan'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to help
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Keluar',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              Navigator.pop(context);
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Keluar'),
          content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                globalLogout();
              },
              child: const Text(
                'Keluar',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  State<BerandaView> createState() => BerandaController();
}
