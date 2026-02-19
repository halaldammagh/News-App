import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/home/category_fragment/category_item.dart';
import 'package:news_app/home/widget/category.dart';
import 'package:news_app/providers/app_theme_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/app_language_provider.dart';

typedef  onCategoryItemClick = void Function(Category);
class CategoryFragment extends StatelessWidget {
   CategoryFragment({super.key, required this.categoryItemClick});

   onCategoryItemClick categoryItemClick;
   List<Category>categoriesList= [];


  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    categoriesList = Category.getCategoriesList(themeProvider.isDarkMode());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width*0.03),
      child: SingleChildScrollView(

        child: Column(
          spacing: height*0.02,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width*0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Good Morning',style:Theme.of(context).textTheme.headlineMedium,).tr(),
                  Text('Here is Some News For You',style:Theme.of(context).textTheme.headlineMedium,).tr(),
                ]
                ,
              ),
            ),
        
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: (){
                        categoryItemClick(categoriesList[index]);
                      },
                      child: CategoryItem(category:categoriesList[index ],));
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: height*0.02,);
                },
                itemCount: categoriesList.length)
          ],
        ),
      )
    );
  }
}
