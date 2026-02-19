import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_app/home/category/category_details.dart';
import 'package:news_app/home/category_fragment/category_fragment.dart';
import 'package:news_app/home/widget/category.dart';

import 'package:news_app/providers/app_theme_provider.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

import 'drawer/home_drawer.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Category? selectedCategory;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedCategory == null?
          'Home'.tr(): selectedCategory!.title.tr(),style: Theme.of(context).textTheme.headlineLarge,),
      ),
      drawer:Drawer(
        backgroundColor: AppColors.blackColor,
        child: HomeDrawer(onDrawerItemClick:onDrawerItemClick ,),
      ),
      body:
      selectedCategory == null?
      CategoryFragment( categoryItemClick: onCategoryItemClick ,):
          CategoryDetails(category: selectedCategory!,),
    );
}


    void onCategoryItemClick(Category newSelectedCategory){
  selectedCategory = newSelectedCategory;

  setState(() {

   });
}


    void onDrawerItemClick(){
      selectedCategory = null;
      Navigator.pop(context);
      setState(() {

      });

    }

    }
