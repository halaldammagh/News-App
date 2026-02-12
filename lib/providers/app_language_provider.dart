import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/shared_prefs.dart';


class AppLanguageProvider extends ChangeNotifier {
  ///todo : data
  String appLanguage = 'en';

  Future<void> loadLanguage() async {
    appLanguage = await SharedPrefs.getLastAppLanguage();
    notifyListeners();
  }

  Future<void> changeLanguage(BuildContext context, String newLanguage) async {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    await context.setLocale(Locale(newLanguage));
    await SharedPrefs.saveLastAppLanguageAndTheme(
      appLanguage,
      await SharedPrefs.getLastAppTheme(),
    );
    notifyListeners();
  }

  bool isEnglish() {
    return appLanguage == 'en';
  }
}