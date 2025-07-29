import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Widget drawer yang dapat digunakan kembali di seluruh aplikasi
class BaseAppDrawer extends StatelessWidget {
  final String? userName;
  final String? userEmail;
  final Widget? userAvatar;
  final List<DrawerMenuModel> menuItems;
  final Color? headerColor;

  const BaseAppDrawer({
    super.key,
    this.userName,
    this.userEmail,
    this.userAvatar,
    required this.menuItems,
    this.headerColor,
  });

  /// Factory constructor untuk drawer beranda dengan menu default
  factory BaseAppDrawer.beranda({
    String? userName,
    String? userEmail,
    Widget? userAvatar,
    Color? headerColor,
    required VoidCallback onRestaurantListTap,
    required VoidCallback onFavoriteTap,
    VoidCallback? onAdminRestaurantTap,
  }) {
    // Create base menu items
    List<DrawerMenuModel> menuItems = [
      DrawerMenuModel(
        title: 'Daftar Restoran',
        icon: Icons.restaurant_outlined,
        onTap: onRestaurantListTap,
      ),
      DrawerMenuModel(
        title: 'Favorit',
        icon: Icons.favorite_outline,
        onTap: onFavoriteTap,
      ),
    ];

    // Add admin menu only for user ID "1" (with test mode support)
    final isAdmin = AdminTestHelper.isCurrentUserAdmin;
    if (isAdmin && onAdminRestaurantTap != null) {
      menuItems.add(
        DrawerMenuModel(
          title: 'Admin Restaurant',
          icon: Icons.admin_panel_settings,
          onTap: onAdminRestaurantTap,
        ),
      );
    }

    return BaseAppDrawer(
      userName: userName,
      userEmail: userEmail,
      userAvatar: userAvatar,
      headerColor: headerColor,
      menuItems: menuItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            _buildDrawerHeader(context),
            ...menuItems.map((item) => _buildMenuItem(context, item)),
            const Spacer(),
            _buildMenuItem(context, DrawerMenuModel.divider()),
            _buildMenuItem(context, DrawerMenuModel.logout(onTap: () {
              _showLogoutDialog(context);
            })),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: headerColor ?? Theme.of(context).primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              userAvatar ??
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    child: Icon(
                      Icons.person,
                      size: 35,
                      color: headerColor ?? Theme.of(context).primaryColor,
                    ),
                  ),
              const SizedBox(width: 8),
              const SwitchThemeWidget()
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName ??
                    SessionService.currentUserData?.displayName ??
                    "User",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                userEmail ??
                    SessionService.currentUserData?.email ??
                    "user@example.com",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, DrawerMenuModel item) {
    if (item.isDivider) {
      return const Divider();
    }

    if (item.isLogout) {
      return ListTile(
        leading: Icon(
          item.icon,
          color: item.iconColor,
        ),
        title: Text(
          item.title,
          style: TextStyle(color: item.textColor),
        ),
        onTap: () {
          Navigator.pop(context);
          _showLogoutDialog(context);
        },
      );
    }

    return ListTile(
      leading: Icon(
        item.icon,
        color: item.iconColor,
      ),
      title: Text(
        item.title,
        style: TextStyle(color: item.textColor),
      ),
      onTap: () {
        Navigator.pop(context);
        item.onTap?.call();
      },
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
                Navigator.of(context).pop();
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
}
