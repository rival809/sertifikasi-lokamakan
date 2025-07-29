// ignore_for_file: camel_case_types
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class SwitchThemeWidget extends StatefulWidget {
  const SwitchThemeWidget({
    super.key,
  });

  @override
  State<SwitchThemeWidget> createState() => _SwitchThemeWidgetState();
}

class _SwitchThemeWidgetState extends State<SwitchThemeWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeData>(
      valueListenable: Get.mainTheme,
      builder: (context, themeData, child) {
        bool isLightMode = themeData.brightness == Brightness.light;
        return AnimatedToggleSwitch<bool>.dual(
          current: isLightMode,
          first: true,
          second: false,
          height: 40,
          style: ToggleStyle(
            borderColor: Theme.of(context).colorScheme.outline,
            indicatorColor: Theme.of(context).colorScheme.primary,
          ),
          styleBuilder: (value) => ToggleStyle(
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          borderWidth: 1,
          onChanged: (b) {
            // Toggle between light and dark theme
            ThemeData newTheme = b ? themeDataLight : themeDataDark;
            Get.changeTheme(newTheme);
          },
          spacing: 0,
          iconBuilder: (value) => value
              ? Icon(
                  Icons.wb_sunny,
                  color: isDarkMode(context)
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onPrimary,
                )
              : Icon(
                  Icons.nightlight_round,
                  color: isDarkMode(context)
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.primary,
                ),
          textBuilder: (value) => value
              ? Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.nightlight_round,
                      color: isDarkMode(context)
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                )
              : Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.wb_sunny,
                      color: isDarkMode(context)
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
