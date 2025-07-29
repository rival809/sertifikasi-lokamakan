import 'package:flutter/material.dart';

bool isDarkMode(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

dynamic isDarkModeCheck(BuildContext context,
    {required dynamic darkModeValue, required dynamic lightModeValue}) {
  if (Theme.of(context).brightness == Brightness.dark) {
    return darkModeValue;
  }
  return lightModeValue;
}
