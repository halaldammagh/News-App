import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:flutter/src/painting/text_style.dart';

class AppStyles {
  static TextStyle medium20White = GoogleFonts.inter(
    fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.whiteColor,);

  static TextStyle medium20Black = GoogleFonts.inter(
    fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.blackColor,);

  static TextStyle medium14White = GoogleFonts.inter(
    fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.whiteColor,);

  static TextStyle medium14Black = GoogleFonts.inter(
    fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.blackColor,);

  static TextStyle medium24White = GoogleFonts.inter(
    fontSize: 24, fontWeight: FontWeight.w500, color: AppColors.whiteColor,);

  static TextStyle medium24Black = GoogleFonts.inter(
    fontSize: 24, fontWeight: FontWeight.w500, color: AppColors.blackColor,);

  static TextStyle bold16Black = GoogleFonts.inter(
    fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.blackColor,);

    static TextStyle bold16White = GoogleFonts.inter(
    fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.whiteColor,);

   static TextStyle medium12Gray = GoogleFonts.inter(
    fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.greyColor,);


}
