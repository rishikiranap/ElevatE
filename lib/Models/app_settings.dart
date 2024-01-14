import 'package:flutter/material.dart';
import 'package:ElevatE/themes/theme.dart';

class AppSettings extends ChangeNotifier {
  var _numberOfQuotes = 4;
  int get numberOfQuotes => _numberOfQuotes;

  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;

  bool _isDarkModeEnabled = false;
  bool get isDarkModeEnabled => _isDarkModeEnabled;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  set numberOfQuotes(int value) {
    _numberOfQuotes = value;
    notifyListeners(); // Notify listeners about the change
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
