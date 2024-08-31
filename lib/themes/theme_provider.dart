import 'package:ad_foodz/themes/dark_mode.dart';
import 'package:ad_foodz/themes/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightmode;

  ThemeData get themedata => _themeData;

  bool get isDarkMode => _themeData == darkmode;

  set themedata(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == darkmode) {
      themedata = lightmode;
    } else {
      themedata = darkmode;
    }
  }
}