import 'package:flutter/material.dart';

/// Model untuk item menu drawer
class DrawerMenuModel {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? textColor;
  final bool isDivider;
  final bool isLogout;

  const DrawerMenuModel({
    required this.title,
    required this.icon,
    this.onTap,
    this.iconColor,
    this.textColor,
    this.isDivider = false,
    this.isLogout = false,
  });

  /// Factory constructor untuk menu logout
  factory DrawerMenuModel.logout({
    required VoidCallback onTap,
  }) {
    return DrawerMenuModel(
      title: 'Keluar',
      icon: Icons.logout,
      onTap: onTap,
      iconColor: Colors.red,
      textColor: Colors.red,
      isLogout: true,
    );
  }

  /// Factory constructor untuk divider
  factory DrawerMenuModel.divider() {
    return const DrawerMenuModel(
      title: '',
      icon: Icons.remove,
      isDivider: true,
    );
  }
}
