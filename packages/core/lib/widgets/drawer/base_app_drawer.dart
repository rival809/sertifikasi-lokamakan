import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Widget drawer yang dapat digunakan kembali di seluruh aplikasi
class BaseAppDrawer extends StatefulWidget {
  final String? userName;
  final String? userEmail;
  final Widget? userAvatar;
  final List<DrawerMenuModel> menuItems;
  final Color? headerColor;

  // Callback functions for dynamic menu building
  final VoidCallback? onRestaurantListTap;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onAdminRestaurantTap;

  const BaseAppDrawer({
    super.key,
    this.userName,
    this.userEmail,
    this.userAvatar,
    required this.menuItems,
    this.headerColor,
    this.onRestaurantListTap,
    this.onFavoriteTap,
    this.onAdminRestaurantTap,
  });

  /// Factory constructor untuk drawer beranda dengan menu default
  factory BaseAppDrawer.beranda({
    String? userName,
    String? userEmail,
    Widget? userAvatar,
    Color? headerColor,
    VoidCallback? onAdminRestaurantTap,
  }) {
    return BaseAppDrawer(
      userName: userName,
      userEmail: userEmail,
      userAvatar: userAvatar,
      headerColor: headerColor,
      menuItems: const [], // Will be built dynamically using ValueListenableBuilder
      onAdminRestaurantTap: onAdminRestaurantTap,
    );
  }

  @override
  State<BaseAppDrawer> createState() => _BaseAppDrawerState();
}

class _BaseAppDrawerState extends State<BaseAppDrawer> {
  List<DrawerMenuModel> _buildMenuItems(bool isAdmin) {
    List<DrawerMenuModel> menuItems = [];

    // If widget.menuItems is not empty, use it (for non-beranda drawers)
    if (widget.menuItems.isNotEmpty) {
      return widget.menuItems;
    }

    // Build dynamic menu for beranda drawer
    if (widget.onRestaurantListTap != null) {
      menuItems.add(
        DrawerMenuModel(
          title: 'Daftar Restoran',
          icon: Icons.restaurant_outlined,
          onTap: widget.onRestaurantListTap!,
        ),
      );
    }

    if (widget.onFavoriteTap != null) {
      menuItems.add(
        DrawerMenuModel(
          title: 'Favorit',
          icon: Icons.favorite_outline,
          onTap: widget.onFavoriteTap!,
        ),
      );
    }

    // Add admin menu only if user is admin
    if (isAdmin && widget.onAdminRestaurantTap != null) {
      menuItems.add(
        DrawerMenuModel(
          title: 'Admin Restaurant',
          icon: Icons.admin_panel_settings,
          onTap: widget.onAdminRestaurantTap!,
        ),
      );
    }

    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder<bool>(
        valueListenable: AdminTestHelper.adminStateNotifier,
        builder: (context, isAdminNotified, child) {
          final isAdmin = AdminTestHelper.isCurrentUserAdmin;
          final menuItems = _buildMenuItems(isAdmin);

          return Drawer(
            backgroundColor: Theme.of(context).colorScheme.surface,
            surfaceTintColor: Colors.transparent,
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
          );
        },
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.headerColor ?? Theme.of(context).primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.userAvatar ??
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    child: Icon(
                      Icons.person,
                      size: 35,
                      color:
                          widget.headerColor ?? Theme.of(context).primaryColor,
                    ),
                  ),
              const SizedBox(width: 8),
              const SwitchThemeWidget()
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userName ??
                          SessionService.currentUserData?.displayName ??
                          "User",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.userEmail ??
                          SessionService.currentUserData?.email ??
                          "user@example.com",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              // Debug button untuk testing admin features
              if (kDebugMode)
                IconButton(
                  icon: Icon(
                    Icons.bug_report,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: () {
                    AdminTestHelper.showAdminTestDialog(context);
                  },
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
