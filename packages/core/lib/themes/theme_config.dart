import 'package:flutter/material.dart';

const TextTheme myTextThemeLight = TextTheme(
  displayLarge: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: neutralOnyx,
  ),
  displayMedium: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: neutralOnyx,
  ),
  displaySmall: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: neutralOnyx,
  ),
  headlineLarge: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: neutralOnyx,
  ),
  headlineMedium: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: neutralOnyx,
  ),
  headlineSmall: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: neutralOnyx,
  ),
  titleLarge: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: neutralOnyx,
  ),
  titleMedium: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: neutralOnyx,
  ),
  titleSmall: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: neutralOnyx,
  ),
  bodyLarge: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: neutralOnyx,
  ),
  bodyMedium: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: neutralOnyx,
  ),
  bodySmall: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: neutralOnyx,
  ),
  labelLarge: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: neutralOnyx,
  ),
  labelMedium: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: neutralOnyx,
  ),
  labelSmall: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: neutralOnyx,
  ),
);
const TextTheme myTextThemeDark = TextTheme(
  displayLarge: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: neutralPure,
  ),
  displayMedium: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: neutralPure,
  ),
  displaySmall: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: neutralPure,
  ),
  headlineLarge: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: neutralPure,
  ),
  headlineMedium: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: neutralPure,
  ),
  headlineSmall: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: neutralPure,
  ),
  titleLarge: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: neutralPure,
  ),
  titleMedium: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: neutralPure,
  ),
  titleSmall: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: neutralPure,
  ),
  bodyLarge: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: neutralPure,
  ),
  bodyMedium: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: neutralPure,
  ),
  bodySmall: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: neutralPure,
  ),
  labelLarge: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: neutralPure,
  ),
  labelMedium: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: neutralPure,
  ),
  labelSmall: TextStyle(
    fontFamily: 'Roboto',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: neutralPure,
  ),
);

TextStyle bodyXSmall(context) {
  return TextStyle(
    fontFamily: 'Roboto',
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: Theme.of(context).colorScheme.onSurface,
  );
}

TextStyle largestBebasNeue = const TextStyle(
  fontFamily: 'BebasNeue',
  fontSize: 75,
  fontWeight: FontWeight.w400,
  color: neutralPure,
);

TextStyle largeBebasNeue = const TextStyle(
  fontFamily: 'BebasNeue',
  fontSize: 64,
  fontWeight: FontWeight.w400,
  color: neutralPure,
);

// Color Light
const Color lightBackground = backgroundLight;
const Color appLightBackground = neutralGhost;

// Color Dark
const Color darkBackground = backgroundDark;

//Primary Palette - Fresh Modern Colors
const Color primaryTeal = Color(0xff00BFA5); // Fresh teal
const Color primaryCoral = Color(0xffFF6B6B); // Vibrant coral
const Color primaryIndigo = Color(0xff667EEA); // Modern indigo
const Color primaryEmerald = Color(0xff10B981); // Fresh emerald
const Color primaryAmber = Color(0xffF59E0B); // Warm amber

// Fresh Neutral Palette
const Color neutralPure = Color(0xffFFFFFF); // Pure white
const Color neutralGhost = Color(0xffFAFBFC); // Ghost white
const Color neutralLight = Color(0xffF1F5F9); // Light gray
const Color neutralMist = Color(0xffE2E8F0); // Mist gray
const Color neutralSilver = Color(0xffCBD5E1); // Silver
const Color neutralStone = Color(0xff94A3B8); // Stone gray
const Color neutralSlate = Color(0xff64748B); // Slate
const Color neutralCharcoal = Color(0xff475569); // Charcoal
const Color neutralGraphite = Color(0xff334155); // Graphite
const Color neutralOnyx = Color(0xff1E293B); // Onyx
const Color neutralEbony = Color(0xff0F172A); // Ebony

// Fresh Accent Colors
const Color accentSky = Color(0xff0EA5E9); // Sky blue
const Color accentViolet = Color(0xff8B5CF6); // Violet
const Color accentRose = Color(0xffF43F5E); // Rose
const Color accentLime = Color(0xff84CC16); // Lime green
const Color accentOrange = Color(0xffF97316); // Orange

// Semantic Colors - Fresh Palette
const Color successFresh = Color(0xff22C55E); // Fresh green
const Color warningFresh = Color(0xffF59E0B); // Amber warning
const Color errorFresh = Color(0xffEF4444); // Modern red
const Color infoFresh = Color(0xff3B82F6); // Blue info

// Background Colors
const Color backgroundLight = Color(0xffFAFBFC); // Light background
const Color backgroundDark = Color(0xff0F172A); // Dark background
const Color surfaceLight = Color(0xffFFFFFF); // Light surface
const Color surfaceDark = Color(0xff1E293B); // Dark surface

// Legacy color mappings for backward compatibility
const Color gray50 = neutralGhost;
const Color gray100 = neutralLight;
const Color gray200 = neutralMist;
const Color gray300 = neutralSilver;
const Color gray400 = neutralStone;
const Color gray500 = neutralSlate;
const Color gray600 = neutralCharcoal;
const Color gray700 = neutralGraphite;
const Color gray800 = neutralOnyx;
const Color gray900 = neutralEbony;

// BlueGray Palette - Fresh version
const Color blueGray50 = neutralLight;
const Color blueGray100 = neutralMist;
const Color blueGray200 = neutralSilver;
const Color blueGray300 = neutralStone;
const Color blueGray400 = neutralSlate;
const Color blueGray500 = neutralCharcoal;
const Color blueGray600 = neutralGraphite;
const Color blueGray700 = neutralOnyx;
const Color blueGray800 = neutralEbony;
const Color blueGray900 = backgroundDark;

// Green Palette - Fresh version
const Color green50 = Color(0xffECFDF5);
const Color green100 = Color(0xffD1FAE5);
const Color green200 = Color(0xffA7F3D0);
const Color green300 = Color(0xff6EE7B7);
const Color green400 = Color(0xff34D399);
const Color green500 = Color(0xff10B981);
const Color green600 = primaryEmerald;
const Color green700 = Color(0xff047857);
const Color green800 = Color(0xff065F46);
const Color green900 = Color(0xff064E3B);

// Red Palette - Fresh version
const Color red50 = Color(0xffFEF2F2);
const Color red100 = Color(0xffFEE2E2);
const Color red200 = Color(0xffFECACA);
const Color red300 = Color(0xffFCA5A5);
const Color red400 = Color(0xffF87171);
const Color red500 = errorFresh;
const Color red600 = Color(0xffDC2626);
const Color red700 = Color(0xffB91C1C);
const Color red800 = Color(0xff991B1B);
const Color red900 = Color(0xff7F1D1D);

// Yellow Palette - Fresh version
const Color yellow50 = Color(0xffFEFCE8);
const Color yellow100 = Color(0xffFEF3C7);
const Color yellow200 = Color(0xffFDE68A);
const Color yellow300 = Color(0xffFCD34D);
const Color yellow400 = Color(0xffFBBF24);
const Color yellow500 = primaryAmber;
const Color yellow600 = Color(0xffD97706);
const Color yellow700 = Color(0xffB45309);
const Color yellow800 = Color(0xff92400E);
const Color yellow900 = Color(0xff78350F);

// Blue Palette - Fresh version
const Color blue50 = Color(0xffEFF6FF);
const Color blue100 = Color(0xffDBEAFE);
const Color blue200 = Color(0xffBFDBFE);
const Color blue300 = Color(0xff93C5FD);
const Color blue400 = Color(0xff60A5FA);
const Color blue500 = infoFresh;
const Color blue600 = Color(0xff2563EB);
const Color blue700 = Color(0xff1D4ED8);
const Color blue800 = Color(0xff1E40AF);
const Color blue900 = Color(0xff1E3A8A);

// Pink Palette - Fresh version
const Color pink50 = Color(0xffFDF2F8);
const Color pink100 = Color(0xffFCE7F3);
const Color pink200 = Color(0xffFBCFE8);
const Color pink300 = Color(0xffF9A8D4);
const Color pink400 = Color(0xffF472B6);
const Color pink500 = Color(0xffEC4899);
const Color pink600 = accentRose;
const Color pink700 = Color(0xffBE185D);
const Color pink800 = Color(0xff9D174D);
const Color pink900 = Color(0xff831843);

// Purple Palette - Fresh version
const Color purple50 = Color(0xffFAF5FF);
const Color purple100 = Color(0xffF3E8FF);
const Color purple200 = Color(0xffE9D5FF);
const Color purple300 = Color(0xffD8B4FE);
const Color purple400 = Color(0xffC084FC);
const Color purple500 = accentViolet;
const Color purple600 = Color(0xff7C3AED);
const Color purple700 = Color(0xff6D28D9);
const Color purple800 = Color(0xff5B21B6);
const Color purple900 = Color(0xff4C1D95);

// Neutral Palette - Updated
const Color neutralWhite = neutralPure;
const Color neutralBlack = backgroundDark;

// Emphasis Palette - Fresh version
const Color lowEmphasis = neutralCharcoal;
const Color mediumEmphasis = neutralSlate;
const Color mediumEmphasis2 = neutralStone;
const Color highEmphasis = neutralLight;

// Text Dark Palette - Fresh version
const Color textLow = neutralStone;
const Color textMedium = neutralSilver;
const Color textHigh = neutralLight;
const Color textError = errorFresh;

// Other Palette - Fresh version
const Color black = backgroundDark;
const Color active = successFresh;
const Color focus = primaryAmber;
const Color error = errorFresh;

var primaryColor = primaryIndigo;
var secondaryColor = neutralOnyx;
var bgColor = backgroundDark;

Color appbarBackgroundColor = primaryEmerald;
Color scaffoldBackgroundColor = neutralPure;
MaterialColor primarySwatch = Colors.teal;
Color drawerBackgroundColor = neutralOnyx;
Color drawerFontColor = neutralLight;

// Legacy color for compatibility
const Color primaryGreen = primaryEmerald;

//Fresh Color Filters - Primary Colors
const colorFilterTeal = ColorFilter.mode(
  primaryTeal,
  BlendMode.srcIn,
);
const colorFilterCoral = ColorFilter.mode(
  primaryCoral,
  BlendMode.srcIn,
);
const colorFilterIndigo = ColorFilter.mode(
  primaryIndigo,
  BlendMode.srcIn,
);
const colorFilterEmerald = ColorFilter.mode(
  primaryEmerald,
  BlendMode.srcIn,
);

//Fresh Color Filters - Accent Colors
const colorFilterSky = ColorFilter.mode(
  accentSky,
  BlendMode.srcIn,
);
const colorFilterViolet = ColorFilter.mode(
  accentViolet,
  BlendMode.srcIn,
);
const colorFilterRose = ColorFilter.mode(
  accentRose,
  BlendMode.srcIn,
);
const colorFilterLime = ColorFilter.mode(
  accentLime,
  BlendMode.srcIn,
);

//Neutral Filters
const colorFilterWhite = ColorFilter.mode(
  neutralPure,
  BlendMode.srcIn,
);
const colorFilterEbony = ColorFilter.mode(
  neutralEbony,
  BlendMode.srcIn,
);
const colorFilterOnyx = ColorFilter.mode(
  neutralOnyx,
  BlendMode.srcIn,
);
const colorFilterCharcoal = ColorFilter.mode(
  neutralCharcoal,
  BlendMode.srcIn,
);
const colorFilterSlate = ColorFilter.mode(
  neutralSlate,
  BlendMode.srcIn,
);
const colorFilterStone = ColorFilter.mode(
  neutralStone,
  BlendMode.srcIn,
);
const colorFilterSilver = ColorFilter.mode(
  neutralSilver,
  BlendMode.srcIn,
);
const colorFilterMist = ColorFilter.mode(
  neutralMist,
  BlendMode.srcIn,
);
const colorFilterLight = ColorFilter.mode(
  neutralLight,
  BlendMode.srcIn,
);
const colorFilterGhost = ColorFilter.mode(
  neutralGhost,
  BlendMode.srcIn,
);

// Legacy numbered colorFilters for compatibility
const colorFilterGray400 = ColorFilter.mode(
  gray400,
  BlendMode.srcIn,
);
const colorFilterGray500 = ColorFilter.mode(
  gray500,
  BlendMode.srcIn,
);
const colorFilterGray600 = ColorFilter.mode(
  gray600,
  BlendMode.srcIn,
);
const colorFilterGreen600 = ColorFilter.mode(
  green600,
  BlendMode.srcIn,
);
const colorFilterGreen700 = ColorFilter.mode(
  green700,
  BlendMode.srcIn,
);
const colorFilterGreen800 = ColorFilter.mode(
  green800,
  BlendMode.srcIn,
);
const colorFilterGreen900 = ColorFilter.mode(
  green900,
  BlendMode.srcIn,
);
const colorFilterRed800 = ColorFilter.mode(
  red800,
  BlendMode.srcIn,
);
const colorFilterYellow800 = ColorFilter.mode(
  yellow800,
  BlendMode.srcIn,
);
const colorFilterBlue800 = ColorFilter.mode(
  blue800,
  BlendMode.srcIn,
);

ColorFilter customColorFilter({required Color color}) {
  return ColorFilter.mode(
    color,
    BlendMode.srcIn,
  );
}
