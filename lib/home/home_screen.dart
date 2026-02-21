import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/home/category/category_details.dart';
import 'package:news_app/home/category_fragment/category_fragment.dart';
import 'package:news_app/home/news/news_item.dart';
import 'package:news_app/home/widget/category.dart';
import 'package:news_app/model/news_response.dart';
import 'package:news_app/providers/app_language_provider.dart';

import 'package:news_app/providers/app_theme_provider.dart';
import 'package:news_app/utils/app_assets.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'drawer/home_drawer.dart';
Timer? _debounce;

class HomeScreen extends StatefulWidget {

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<News> searchResults = [];
  bool isLoadingSearch = false;

  Category? selectedCategory;
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return Scaffold(
      appBar:
      AppBar(
        toolbarHeight: height*0.08, // 👈 زود الارتفاع
        title: isSearching
            ?Container(
              height: height*0.06,
              child: TextFormField(
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();

                  _debounce = Timer(const Duration(milliseconds: 600), () {
                    if (value.isNotEmpty) {
                      searchResults.clear();
                      performSearch(value);
                    }
                  });
                },


                cursorColor: themeProvider.isDarkMode()?AppColors.whiteColor:AppColors.blackColor,
                cursorHeight: height*0.02,
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.start,

                decoration: InputDecoration(
                  prefixIcon: Image.asset(themeProvider.isDarkMode()?AppAssets.searchIcon:AppAssets.lightSearchIcon),
                suffixIcon: InkWell(
                  onTap: (){
                    isSearching=false;
                    searchResults.clear();
                    setState(() {

                    });
                  },
                  child: Image.asset(themeProvider.isDarkMode()?AppAssets.closeIcon:AppAssets.lightCloseIcon),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    width: 1,
                      color: themeProvider.isDarkMode()?AppColors.whiteColor:AppColors.blackColor
                  )
              ),
              focusedBorder: OutlineInputBorder(

                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  width: 1,
                  color: themeProvider.isDarkMode()?AppColors.whiteColor:AppColors.blackColor
                )
              ),
                  hintText: 'Search'.tr(),
                  hintStyle: Theme.of(context).textTheme.headlineLarge
                          ),
                        ),
            )
            : Text(
          selectedCategory == null
              ? 'Home'.tr()
              : selectedCategory!.title.tr(),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        actions: [
          if (selectedCategory != null && !isSearching)
            InkWell(
              onTap: () {
                setState(() {
                  isSearching = true;
                });
              },
              child: Padding(
                padding: EdgeInsets.only(right: width * 0.04,left:languageProvider.isEnglish()?0:width*0.04 ),
                child: Image.asset(
                  themeProvider.isDarkMode()
                      ? AppAssets.searchIcon
                      : AppAssets.lightSearchIcon,
                ),
              ),
            ),
        ],
      ),
      drawer: isSearching
          ? null
          : Drawer(
        backgroundColor: AppColors.blackColor,
        child: HomeDrawer(
          onDrawerItemClick: onDrawerItemClick,
        ),
      ),

      body: isSearching
          ? (isLoadingSearch
          ? const Center(child: CircularProgressIndicator())
          : (searchResults.isEmpty
          ? Center(child: Text("No Results Found", style: Theme.of(context).textTheme.headlineLarge,))
          : ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return NewsItem(
            news: searchResults[index],
          );
        },
      )))
          : (selectedCategory == null
          ? CategoryFragment(categoryItemClick: onCategoryItemClick)
          : CategoryDetails(category: selectedCategory!)),

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

    Future<void> performSearch(String query) async {
    setState(() {
      isLoadingSearch = true;
    });

    try{
      var response = await ApiManager.searchNews(query);
      setState(() {
        searchResults = response.articles??[];
      });

    }catch(e){
      print(e);
    }

    setState(() {
      isLoadingSearch = false;
    });
    }

    }
