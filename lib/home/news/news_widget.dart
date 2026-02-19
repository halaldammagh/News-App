import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/home/news/news_item.dart';
import 'package:news_app/home/widget/main_error_widget.dart';
import 'package:news_app/home/widget/main_loading_widget.dart';
import 'package:news_app/model/news_response.dart';
import 'package:news_app/model/source_response.dart';
import 'package:news_app/utils/app_colors.dart';

class NewsWidget extends StatefulWidget {
   NewsWidget({super.key, required this.source});
  final Source source;

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return FutureBuilder<NewsResponse>(
        future: ApiManager.getNewsBySourceId(widget.source.id??''),
        builder: (context , snapShot){
          if(snapShot.connectionState == ConnectionState.waiting){
            //todo: loading

            return MainLoadingWidget();
          }else if(snapShot.hasError){
            return Center(
              child: MainErrorWidget(errorMessage: 'Something went wrong',
                  onPressed:(){
                 ApiManager.getNewsBySourceId(widget.source.id??'');
                 setState(() {

                 });
              }),
            );
          }
          //todo: server => response => success , error
           if(snapShot.data!.status == 'error'){
             return MainErrorWidget(errorMessage: snapShot.data!.message!,
                 onPressed: (){
               ApiManager.getNewsBySourceId(widget.source.id??'');
                 });
           }


          //todo:  success
           var newsList = snapShot.data?.articles??[];
          if(newsList.isEmpty){
            return Center(
              child: Text('No Sources Item Found',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            );
          }else {
            return ListView.separated(
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
            );
          }
        }
        );
  }
}
