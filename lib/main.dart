import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/home/home_screen.dart';
import 'package:news_app/providers/app_language_provider.dart';
import 'package:news_app/providers/app_theme_provider.dart';
import 'package:news_app/utils/app_routes.dart';
import 'package:news_app/utils/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() {
  final langProvider = AppLanguageProvider();
  final themeProvider = AppThemeProvider();
  WidgetsFlutterBinding.ensureInitialized();
  timeago.setLocaleMessages('en', timeago.EnMessages());
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  timeago.setLocaleMessages('ar_short', timeago.ArShortMessages());
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [], // 👈 بيشيل الستاتس بار كامل
  );

  runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: Locale(langProvider.appLanguage),
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => langProvider),
            ChangeNotifierProvider(create: (_) => themeProvider),
          ],
          child: const MyApp(),
        ),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider =Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "News App",
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode:themeProvider.appTheme,
      initialRoute: AppRoutes.homeScreenRoute,
      routes:{
        AppRoutes.homeScreenRoute:(context) => HomeScreen(),
      },
    );
  }
}
