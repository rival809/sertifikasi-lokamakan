import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ThemeDatabase {
  static ThemeMode themeMode = ThemeMode.system;

  static load() async {
    themeMode = mainStorage.get("themeMode") ?? ThemeMode.system;
  }

  static save(ThemeMode themeMode) async {
    mainStorage.put("themeMode", themeMode);

    ThemeDatabase.themeMode = themeMode;
  }
}
