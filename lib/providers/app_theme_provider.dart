import 'package:flutter/material.dart';

import '../utils/shared_prefs.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  Future<void> loadTheme() async {
    final lastTheme = await SharedPrefs.getLastAppTheme();
    appTheme = (lastTheme == 'dark') ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> changeTheme(ThemeMode newTheme) async {
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme;
    await SharedPrefs.saveLastAppLanguageAndTheme(
      await SharedPrefs.getLastAppLanguage(),
      newTheme == ThemeMode.dark ? 'dark' : 'light',
    );
    notifyListeners();
  }

  bool isDarkMode() {
    return appTheme == ThemeMode.dark;
  }
}
