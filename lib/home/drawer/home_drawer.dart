import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/home/drawer/divider_item.dart';
import 'package:news_app/home/drawer/drawer_item.dart';
import 'package:news_app/home/drawer/language/language_bottom_sheet.dart';
import 'package:news_app/home/drawer/selected_item.dart';
import 'package:news_app/providers/app_language_provider.dart';
import 'package:news_app/providers/app_theme_provider.dart';
import 'package:news_app/utils/app_assets.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_routes.dart';
import 'package:news_app/utils/app_styles.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  final VoidCallback onDrawerItemClick;
   HomeDrawer({super.key, required this.onDrawerItemClick});

  @override
  Widget build(BuildContext context) {
    var themeProvider  = Provider.of<AppThemeProvider>(context);
    var languageProvider  = Provider.of<AppLanguageProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      spacing: height*0.02,
      crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Container(
             alignment: Alignment.center,
              color: AppColors.whiteColor,
             height: height*0.21,
             child: Text('News App',style: AppStyles.bold24Black,).tr(),

           ),
           InkWell(
               onTap: (){
                 onDrawerItemClick();
               },
               child: DrawerItem(text: 'Go To Home', iconName: AppAssets.homeIcon,)),
           DividerItem(),
           DrawerItem(text: 'Them', iconName: AppAssets.themeIcon),
           SelectedItem<String>(
             text: themeProvider.isDarkMode()?'Dark'.tr():'Light'.tr(),
             items: [
               PopupMenuItem(value: 'dark', child: Text('Dark'.tr(),style: const TextStyle(color: Colors.white),)),
               PopupMenuItem(value: 'light', child: Text('Light'.tr(),style: TextStyle(color: Colors.white),)),
             ],
             onSelected: (value){
               themeProvider.changeTheme(value == 'dark' ? ThemeMode.dark : ThemeMode.light);

             }
           ),
           DividerItem(),
           DrawerItem(text: 'Language'.tr(), iconName: AppAssets.langIcon),
           SelectedItem<String>(
             text: languageProvider.isEnglish()?'English'.tr():'Arabic'.tr(),
             items: [
               PopupMenuItem(value: 'en', child: Text('English'.tr(),style: TextStyle(color: Colors.white),)),
               PopupMenuItem(value: 'ar', child: Text('Arabic'.tr(),style: TextStyle(color: Colors.white),)),
             ],
             onSelected: (value)  {
                   languageProvider.changeLanguage(context, value); }// value هي en أو ar

           )

         ],
       );

  }
}
