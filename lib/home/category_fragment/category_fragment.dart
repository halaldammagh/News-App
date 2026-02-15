import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/home/category_fragment/category_item.dart';
import 'package:news_app/home/widget/category.dart';
import 'package:news_app/providers/app_theme_provider.dart';
import 'package:provider/provider.dart';

class CategoryFragment extends StatelessWidget {
   CategoryFragment({super.key});
   List<Category>categoriesList= [];

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    categoriesList = Category.getCategoriesList(themeProvider.isDarkMode());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width*0.03),
      child: Column(
        spacing: height*0.02,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Good Morning',style:Theme.of(context).textTheme.headlineMedium,).tr(),
          Text('Here is Some News For You',style:Theme.of(context).textTheme.headlineMedium,).tr(),

          Expanded(child: ListView.separated(
              itemBuilder: (context, index) {
                return CategoryItem(category:categoriesList[index ],);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: height*0.02,);
              },
              itemCount: categoriesList.length))
        ],
      ),
    );
  }
}
