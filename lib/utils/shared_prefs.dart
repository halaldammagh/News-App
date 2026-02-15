import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String _langKey = 'app_language';
  static const String _themeKey = 'app_theme';

//todo: save last language and theme => write data
  static Future<void> saveLastAppLanguageAndTheme(String appLanguage, String appTheme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPrefs._langKey, appLanguage);
    await prefs.setString(SharedPrefs._themeKey, appTheme);
  }


  //todo: get last language and theme  => read data
  static Future<String> getLastAppLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefs._langKey) ?? 'en';
  }

  static Future<String> getLastAppTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefs._themeKey) ?? 'dark';
  }


}

