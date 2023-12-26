import 'package:flutter/material.dart';
import 'package:ElevatE/themes/theme.dart';

class AppSettings extends ChangeNotifier {
  int _numberOfQuotes = 6;
  int get numberOfQuotes => _numberOfQuotes;

  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;

  bool _isDarkModeEnabled = false;
  bool get isDarkModeEnabled => _isDarkModeEnabled;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkModeEnabled = !_isDarkModeEnabled;
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }

  void updateNumberOfQuotes(int newNumberOfQuotes) {
    _numberOfQuotes = newNumberOfQuotes;
    notifyListeners();
  }
}
