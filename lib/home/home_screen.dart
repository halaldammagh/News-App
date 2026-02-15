import 'package:flutter/material.dart';
import 'package:news_app/home/category/category_details.dart';
import 'package:news_app/home/category_fragment/category_fragment.dart';

import 'package:news_app/providers/app_theme_provider.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

import 'drawer/home_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home',style: Theme.of(context).textTheme.headlineLarge,),
      ),
      drawer:Drawer(
        backgroundColor: AppColors.blackColor,
        child: HomeDrawer(),
      ),
      body: CategoryFragment(),
    );
}}
