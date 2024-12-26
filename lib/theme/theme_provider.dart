import 'package:flutter/material.dart';
import 'package:habit_tracker/theme/dark_mode.dart';
import 'package:habit_tracker/theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  //Default mode
  ThemeData _themeData = lightMode;

  //Fetching the current theme
  ThemeData get themeData => _themeData;

  //Checking whether it is a dark mode
  bool get isDarkMode => _themeData == darkMode;

  //Theme setter
  set themeData(ThemeData themedata) {
    _themeData = themeData;
    notifyListeners();
  }

  //Toggling the theme
  ThemeData toggleTheme() {
    return isDarkMode ? lightMode : darkMode;
  }
}
