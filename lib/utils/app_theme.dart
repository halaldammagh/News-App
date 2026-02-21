import 'package:flutter/material.dart';
import 'package:news_app/utils/app_styles.dart' show AppStyles;

import 'app_colors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.whiteColor,
    splashColor: AppColors.blackColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: const AppBarTheme(
      elevation: 0,                // يشيل الظل العادي
      scrolledUnderElevation: 0,   // يشيل الظل لما تسكّري/تسكرولي
      shadowColor: Colors.transparent, //
      backgroundColor: AppColors.whiteColor,
      iconTheme: IconThemeData(color: AppColors.blackColor),
      centerTitle: true,
    ),
    textTheme: TextTheme(

     labelLarge: AppStyles.bold16Black,
      labelSmall:AppStyles.medium12Gray,
      labelMedium: AppStyles.medium14Black,
      headlineMedium: AppStyles.medium24Black,
      headlineLarge: AppStyles.medium20Black,
      bodyLarge: AppStyles.bold40White,
      bodyMedium: AppStyles.medium14White,
    ),


  );

  static final ThemeData darkTheme = ThemeData(

    scaffoldBackgroundColor: AppColors.blackColor,
    primaryColor: AppColors.blackColor,
    splashColor: AppColors.whiteColor,
    appBarTheme: const AppBarTheme(
      elevation: 0,                // يشيل الظل العادي
      scrolledUnderElevation: 0,   // يشيل الظل لما تسكّري/تسكرولي
      shadowColor: Colors.transparent, //
      backgroundColor: AppColors.blackColor,
      iconTheme: IconThemeData(color: AppColors.whiteColor),
      centerTitle: true,
    ),
    textTheme: TextTheme(
        labelLarge:AppStyles.bold16White,
        labelSmall:AppStyles.medium12Gray,
        labelMedium:AppStyles.medium14White,
        headlineMedium:AppStyles.medium24White,
        headlineLarge:AppStyles.medium20White,
        bodyLarge: AppStyles.bold40Black,
      bodyMedium: AppStyles.medium14Black


    ),


  );
}
