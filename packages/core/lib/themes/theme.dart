import 'package:core/themes/theme_config.dart';
import 'package:flutter/material.dart';

ThemeData themeDataLight = ThemeData(useMaterial3: true).copyWith(
  // Primary Colors
  primaryColor: primaryEmerald,
  navigationDrawerTheme: const NavigationDrawerThemeData(
    backgroundColor: surfaceLight,
    elevation: 16,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: primaryEmerald,
    selectionHandleColor: primaryEmerald,
    selectionColor: primaryEmerald.withOpacity(0.24),
  ),

  // Background Colors
  scaffoldBackgroundColor: backgroundLight,
  canvasColor: surfaceLight,

  // Surface Colors
  // backgroundColor: deprecated, now uses colorScheme.background
  // bottomAppBarColor: deprecated, now uses colorScheme.surface

  // Accent & Secondary Colors
  hoverColor: neutralMist,
  focusColor: primaryTeal.withOpacity(0.12),
  highlightColor: primaryEmerald.withOpacity(0.12),
  splashColor: primaryEmerald.withOpacity(0.24),

  // Selection Colors
  unselectedWidgetColor: neutralStone,

  // Disabled Colors
  disabledColor: neutralStone,

  // Divider Colors
  dividerColor: neutralMist,

  // Indicator Colors
  indicatorColor: primaryEmerald,

  // Shadow Color
  shadowColor: neutralOnyx.withOpacity(0.16),

  colorScheme: const ColorScheme.light(
    brightness: Brightness.light,
    background: backgroundLight,
    onBackground: neutralOnyx,
    surface: surfaceLight,
    onSurface: neutralOnyx,
    outline: neutralMist,
    primary: primaryEmerald,
    onPrimary: neutralPure,
    secondary: neutralSilver,
    onSecondary: neutralCharcoal,
    tertiary: primaryTeal,
    onTertiary: neutralPure,
    error: errorFresh,
    onError: neutralPure,
    primaryContainer: green50,
    onPrimaryContainer: green800,
    secondaryContainer: yellow50,
    onSecondaryContainer: yellow800,
    tertiaryContainer: blue50,
    onTertiaryContainer: blue800,
    errorContainer: red50,
    onErrorContainer: red800,
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: primaryEmerald,
    foregroundColor: neutralPure,
    elevation: 0,
    shadowColor: neutralOnyx.withOpacity(0.1),
    surfaceTintColor: Colors.transparent,
    titleTextStyle: myTextThemeLight.headlineSmall?.copyWith(
      color: neutralPure,
    ),
    iconTheme: const IconThemeData(
      color: neutralPure,
      size: 24,
    ),
    actionsIconTheme: const IconThemeData(
      color: neutralPure,
      size: 24,
    ),
  ),

  // Card Theme - using cardTheme instead of deprecated cardColor
  cardTheme: const CardTheme(
    color: surfaceLight,
    shadowColor: neutralOnyx,
    elevation: 2,
    margin: EdgeInsets.all(4),
  ),

  // Button Themes
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryEmerald,
      foregroundColor: neutralPure,
      shadowColor: neutralOnyx.withOpacity(0.3),
      elevation: 2,
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: primaryEmerald,
      side: const BorderSide(color: primaryEmerald),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: primaryEmerald,
    ),
  ),

  // Input Decoration Theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: neutralGhost,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: neutralMist),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: neutralMist),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: primaryEmerald, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: errorFresh),
    ),
    labelStyle: const TextStyle(color: neutralSlate),
    hintStyle: const TextStyle(color: neutralStone),
  ),

  // Checkbox Theme
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryEmerald;
      }
      return surfaceLight;
    }),
    checkColor: MaterialStateProperty.all(neutralPure),
  ),

  // Radio Theme
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryEmerald;
      }
      return neutralStone;
    }),
  ),

  // Switch Theme
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryEmerald;
      }
      return neutralStone;
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryEmerald.withOpacity(0.5);
      }
      return neutralMist;
    }),
  ),

  // Progress Indicator Theme
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: primaryEmerald,
    linearTrackColor: neutralMist,
    circularTrackColor: neutralMist,
  ),

  // Bottom Navigation Bar Theme
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: surfaceLight,
    selectedItemColor: primaryEmerald,
    unselectedItemColor: neutralStone,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),

  // Bottom App Bar Theme - replacement for deprecated bottomAppBarColor
  bottomAppBarTheme: const BottomAppBarTheme(
    color: surfaceLight,
    elevation: 8,
    height: 60,
  ),

  // Tab Bar Theme
  tabBarTheme: const TabBarTheme(
    labelColor: primaryEmerald,
    unselectedLabelColor: neutralStone,
    indicatorColor: primaryEmerald,
  ),

  // Drawer Theme
  drawerTheme: DrawerThemeData(
    backgroundColor: surfaceLight,
    scrimColor: neutralOnyx.withOpacity(0.54),
    elevation: 16,
  ),

  // Floating Action Button Theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primaryEmerald,
    foregroundColor: neutralPure,
    elevation: 6,
  ),

  // Snack Bar Theme
  snackBarTheme: SnackBarThemeData(
    backgroundColor: neutralOnyx,
    contentTextStyle: const TextStyle(color: neutralPure),
    actionTextColor: primaryEmerald,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),

  // Dialog Theme - using dialogTheme instead of deprecated dialogBackgroundColor
  dialogTheme: DialogTheme(
    backgroundColor: surfaceLight,
    elevation: 24,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    titleTextStyle: myTextThemeLight.headlineMedium,
    contentTextStyle: myTextThemeLight.bodyMedium,
  ),

  // Tooltip Theme
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: neutralOnyx.withOpacity(0.9),
      borderRadius: BorderRadius.circular(4),
    ),
    textStyle: const TextStyle(
      color: neutralPure,
      fontSize: 12,
    ),
  ),

  // Menu Theme
  menuTheme: MenuThemeData(
    style: MenuStyle(
      backgroundColor: MaterialStateProperty.all(surfaceLight),
      surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(neutralOnyx),
      elevation: MaterialStateProperty.all(8),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  ),

  // List Tile Theme
  listTileTheme: const ListTileThemeData(
    tileColor: Colors.transparent,
    selectedTileColor: primaryEmerald,
    selectedColor: neutralPure,
    textColor: neutralOnyx,
    iconColor: neutralSlate,
  ),

  textTheme: myTextThemeLight,
);

ThemeData themeDataDark = ThemeData.dark(useMaterial3: true).copyWith(
  // Primary Colors
  primaryColor: primaryEmerald,
  navigationDrawerTheme: const NavigationDrawerThemeData(
    backgroundColor: surfaceDark,
    elevation: 16,
  ),

  // Background Colors
  scaffoldBackgroundColor: backgroundDark,
  canvasColor: surfaceDark,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: primaryEmerald,
    selectionHandleColor: primaryEmerald,
    selectionColor: primaryEmerald.withOpacity(0.24),
  ),

  // Surface Colors
  // backgroundColor: deprecated, now uses colorScheme.background
  // bottomAppBarColor: deprecated, now uses colorScheme.surface

  // Accent & Secondary Colors
  hoverColor: neutralGraphite,
  focusColor: primaryTeal.withOpacity(0.24),
  highlightColor: primaryEmerald.withOpacity(0.24),
  splashColor: primaryEmerald.withOpacity(0.32),

  // Selection Colors
  unselectedWidgetColor: neutralSlate,

  // Disabled Colors
  disabledColor: neutralSlate,

  // Divider Colors
  dividerColor: neutralCharcoal,

  // Indicator Colors
  indicatorColor: primaryEmerald,

  // Shadow Color
  shadowColor: neutralEbony.withOpacity(0.4),

  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    background: backgroundDark,
    onBackground: neutralPure,
    surface: surfaceDark,
    onSurface: neutralPure,
    outline: neutralCharcoal,
    primary: primaryEmerald,
    onPrimary: neutralPure,
    secondary: neutralOnyx,
    onSecondary: neutralLight,
    tertiary: primaryTeal,
    onTertiary: neutralPure,
    error: errorFresh,
    onError: neutralPure,
    primaryContainer: neutralOnyx,
    onPrimaryContainer: primaryEmerald,
    secondaryContainer: neutralOnyx,
    onSecondaryContainer: primaryAmber,
    tertiaryContainer: neutralOnyx,
    onTertiaryContainer: primaryTeal,
    errorContainer: neutralOnyx,
    onErrorContainer: errorFresh,
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: primaryEmerald,
    foregroundColor: neutralPure,
    elevation: 0,
    shadowColor: neutralEbony.withOpacity(0.2),
    surfaceTintColor: Colors.transparent,
    titleTextStyle: myTextThemeDark.headlineSmall?.copyWith(
      color: neutralPure,
    ),
    iconTheme: const IconThemeData(
      color: neutralPure,
      size: 24,
    ),
    actionsIconTheme: const IconThemeData(
      color: neutralPure,
      size: 24,
    ),
  ),

  // Card Theme - using cardTheme instead of deprecated cardColor
  cardTheme: const CardTheme(
    color: surfaceDark,
    shadowColor: neutralEbony,
    elevation: 4,
    margin: EdgeInsets.all(4),
  ),

  // Button Themes
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryEmerald,
      foregroundColor: neutralPure,
      shadowColor: neutralEbony.withOpacity(0.5),
      elevation: 3,
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: primaryEmerald,
      side: const BorderSide(color: primaryEmerald),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: primaryEmerald,
    ),
  ),

  // Input Decoration Theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: neutralOnyx,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: neutralCharcoal),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: neutralCharcoal),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: primaryEmerald, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: errorFresh),
    ),
    labelStyle: const TextStyle(color: neutralSilver),
    hintStyle: const TextStyle(color: neutralSlate),
  ),

  // Checkbox Theme
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryEmerald;
      }
      return surfaceDark;
    }),
    checkColor: MaterialStateProperty.all(neutralPure),
    side: const BorderSide(color: neutralCharcoal),
  ),

  // Radio Theme
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryEmerald;
      }
      return neutralSlate;
    }),
  ),

  // Switch Theme
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryEmerald;
      }
      return neutralSlate;
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryEmerald.withOpacity(0.5);
      }
      return neutralCharcoal;
    }),
  ),

  // Progress Indicator Theme
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: primaryEmerald,
    linearTrackColor: neutralCharcoal,
    circularTrackColor: neutralCharcoal,
  ),

  // Bottom Navigation Bar Theme
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: surfaceDark,
    selectedItemColor: primaryEmerald,
    unselectedItemColor: neutralSlate,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),

  // Bottom App Bar Theme - replacement for deprecated bottomAppBarColor
  bottomAppBarTheme: const BottomAppBarTheme(
    color: surfaceDark,
    elevation: 8,
    height: 60,
  ),

  // Tab Bar Theme
  tabBarTheme: const TabBarTheme(
    labelColor: primaryEmerald,
    unselectedLabelColor: neutralSlate,
    indicatorColor: primaryEmerald,
  ),

  // Drawer Theme
  drawerTheme: const DrawerThemeData(
    backgroundColor: surfaceDark,
    scrimColor: neutralEbony,
    elevation: 16,
  ),

  // Floating Action Button Theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primaryEmerald,
    foregroundColor: neutralPure,
    elevation: 6,
  ),

  // Snack Bar Theme
  snackBarTheme: SnackBarThemeData(
    backgroundColor: neutralGraphite,
    contentTextStyle: const TextStyle(color: neutralPure),
    actionTextColor: primaryEmerald,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),

  // Dialog Theme - using dialogTheme instead of deprecated dialogBackgroundColor
  dialogTheme: DialogTheme(
    backgroundColor: surfaceDark,
    elevation: 24,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    titleTextStyle: myTextThemeDark.headlineMedium,
    contentTextStyle: myTextThemeDark.bodyMedium,
  ),

  // Tooltip Theme
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: neutralCharcoal.withOpacity(0.95),
      borderRadius: BorderRadius.circular(4),
    ),
    textStyle: const TextStyle(
      color: neutralPure,
      fontSize: 12,
    ),
  ),

  // Menu Theme
  menuTheme: MenuThemeData(
    style: MenuStyle(
      backgroundColor: MaterialStateProperty.all(surfaceDark),
      surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(neutralEbony),
      elevation: MaterialStateProperty.all(8),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  ),

  // List Tile Theme
  listTileTheme: const ListTileThemeData(
    tileColor: Colors.transparent,
    selectedTileColor: primaryEmerald,
    selectedColor: neutralPure,
    textColor: neutralPure,
    iconColor: neutralSilver,
  ),

  textTheme: myTextThemeDark,
);
