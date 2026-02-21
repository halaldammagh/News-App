import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/home/news/news_item.dart';
import 'package:news_app/home/widget/main_error_widget.dart';
import 'package:news_app/home/widget/main_loading_widget.dart';
import 'package:news_app/model/news_response.dart';
import 'package:news_app/model/source_response.dart';
import 'package:news_app/providers/app_language_provider.dart';
import 'package:news_app/providers/app_theme_provider.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:provider/provider.dart';


class NewsWidget extends StatefulWidget {
  NewsWidget({super.key, required this.source});

  final Source source;

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  int page = 1;
  final int pageSize = 10;
  bool isLoading = false;
  bool hasNext = true;
  String? errorMessage;

  List<News> newsList = [];

  Future<void> getNewsPage(int newPage) async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await ApiManager.getNewsBySourceId(
        widget.source.id ?? '',
        page: newPage,
        pageSize: pageSize,
      );

      if (response.status == 'error') {
        setState(() {
          errorMessage = response.message ?? 'Something went wrong';
        });
        return;
      }

      setState(() {
        page = newPage;
        newsList = response.articles ?? []; // ✅ نستبدل العشرة
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Something went wrong';
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    getNewsPage(1);
  }

  @override
  void didUpdateWidget(covariant NewsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.source.id != widget.source.id) {
      page = 1;
      hasNext = true;
      newsList = [];
      errorMessage = null;
      getNewsPage(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    if (errorMessage != null) {
      return Center(
        child: MainErrorWidget(
          errorMessage: errorMessage!,
          onPressed: () => getNewsPage(page),
        ),
      );
    }

    if (isLoading && newsList.isEmpty) {
      return MainLoadingWidget();
    }

    if (newsList.isEmpty) {
      return Center(
        child: Text(
          'No News Found',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: height * 0.01),
            separatorBuilder: (context, index) {
              return Container(
                color: AppColors.transParentColor,
                height: height * 0.0002,
              );
            },
            itemBuilder: (context, index) {
              return NewsItem(news: newsList[index]);
            },
            itemCount: newsList.length,
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: (!isLoading && page > 1)
                    ? () => getNewsPage(page - 1)
                    : null,
                child: page == 1 ?Text(''):Text("Previous".tr(),style: TextStyle(color:themeProvider.isDarkMode()?AppColors.whiteColor:AppColors.blackColor),),
              ),
               Row(
                 spacing: width*0.01,
                 children: [
                   Text("Page".tr(),
                       style:TextStyle(
                           color:themeProvider.isDarkMode()?
                           AppColors.whiteColor:
                           AppColors.blackColor)),
                   Text( "$page",
                       style:TextStyle(
                           color:themeProvider.isDarkMode()?
                           AppColors.whiteColor:
                           AppColors.blackColor)),
                 ],
               ),


              TextButton(
                onPressed: (!isLoading )
                    ? () => getNewsPage(page + 1)
                    : null,
                child: page== 10 ?Text(""):Text("Next",
                    style:TextStyle(
                        color:themeProvider.isDarkMode()?
                        AppColors.whiteColor:
                        AppColors.blackColor)).tr(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
