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

  // Location info
  final Position? userLocation;
  final bool isLocationEnabled;
  final bool isRetryingLocation;
  final VoidCallback? onLocationTap;

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
    this.userLocation,
    this.isLocationEnabled = false,
    this.isRetryingLocation = false,
    this.onLocationTap,
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
    Position? userLocation,
    bool isLocationEnabled = false,
    bool isRetryingLocation = false,
    VoidCallback? onLocationTap,
    VoidCallback? onAdminRestaurantTap,
  }) {
    return BaseAppDrawer(
      userName: userName,
      userEmail: userEmail,
      userAvatar: userAvatar,
      headerColor: headerColor,
      userLocation: userLocation,
      isLocationEnabled: isLocationEnabled,
      isRetryingLocation: isRetryingLocation,
      onLocationTap: onLocationTap,
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
          const SizedBox(height: 12),
          _buildLocationInfo(context),
        ],
      ),
    );
  }

  Widget _buildLocationInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            child: Icon(
              _getLocationIcon(),
              color: _getLocationColor(context),
              size: 12,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lokasi Saat Ini',
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _getLocationText(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (widget.onLocationTap != null)
            Tooltip(
              message: widget.isRetryingLocation
                  ? 'Mencoba mendapatkan lokasi...'
                  : widget.isLocationEnabled
                      ? 'Refresh lokasi'
                      : 'Pengaturan lokasi',
              child: InkWell(
                onTap: widget.isRetryingLocation ? null : widget.onLocationTap,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  child: widget.isRetryingLocation
                      ? SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        )
                      : Icon(
                          widget.isLocationEnabled
                              ? Icons.refresh
                              : Icons.settings,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 18,
                        ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  IconData _getLocationIcon() {
    if (!widget.isLocationEnabled) {
      return Icons.location_off;
    } else if (widget.userLocation == null) {
      return Icons.location_searching;
    } else {
      return Icons.location_on;
    }
  }

  Color _getLocationColor(BuildContext context) {
    if (!widget.isLocationEnabled) {
      return Colors.red.shade300;
    } else if (widget.userLocation == null) {
      return Colors.orange.shade300;
    } else {
      return Colors.green.shade300;
    }
  }

  String _getLocationText() {
    if (widget.isRetryingLocation) {
      return 'Mencoba mendapatkan lokasi...\nMohon tunggu';
    } else if (!widget.isLocationEnabled) {
      return 'Lokasi dinonaktifkan\nTap untuk mengaktifkan';
    } else if (widget.userLocation == null) {
      return 'Mencari lokasi...\nTap untuk coba lagi';
    } else {
      final lat = widget.userLocation!.latitude.toStringAsFixed(4);
      final lng = widget.userLocation!.longitude.toStringAsFixed(4);
      final accuracy = widget.userLocation!.accuracy.toStringAsFixed(0);

      // Format timestamp
      String timeInfo = '';
      final now = DateTime.now();
      final diff = now.difference(widget.userLocation!.timestamp);
      if (diff.inMinutes < 1) {
        timeInfo = ' • Baru saja';
      } else if (diff.inMinutes < 60) {
        timeInfo = ' • ${diff.inMinutes}m lalu';
      } else if (diff.inHours < 24) {
        timeInfo = ' • ${diff.inHours}h lalu';
      }

      return 'Lokasi ditemukan$timeInfo\n$lat, $lng (±${accuracy}m)';
    }
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
