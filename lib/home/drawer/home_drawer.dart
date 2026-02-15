import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/home/drawer/divider_item.dart';
import 'package:news_app/home/drawer/drawer_item.dart';
import 'package:news_app/home/drawer/selected_item.dart';
import 'package:news_app/utils/app_assets.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_styles.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
           DrawerItem(text: 'Go To Home', iconName: AppAssets.homeIcon),
           DividerItem(),

           DrawerItem(text: 'Them', iconName: AppAssets.themeIcon),
            SelectedItem(text: 'Dark', onPressed: (){},),
           DividerItem(),
           DrawerItem(text: 'Language', iconName: AppAssets.langIcon),
           SelectedItem(text:'English', onPressed: (){},),



         ],
       );

  }
}
