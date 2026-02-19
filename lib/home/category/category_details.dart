import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/home/sources/source_widget.dart';
import 'package:news_app/home/widget/category.dart';
import 'package:news_app/home/widget/main_error_widget.dart';
import 'package:news_app/home/widget/main_loading_widget.dart';
import 'package:news_app/model/source_response.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_styles.dart';

class CategoryDetails extends StatefulWidget {
  Category category;
   CategoryDetails({super.key, required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse>(
      future: ApiManager.getSources(widget.category.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
        //todo: loading
          return MainLoadingWidget();
        }else if(snapshot.hasError){
          return Center(
            child: MainErrorWidget(
                errorMessage: 'Something went wrong',
                onPressed: (){
                  ApiManager.getSources(widget.category.id);
                  setState(() {

                  });
                })
          );
        }
        //todo: server => response => success , error
        if(snapshot.data?.status != 'ok'){
          return MainErrorWidget(errorMessage: snapshot.data!.message!,
              onPressed:(){
            ApiManager.getSources(widget.category.id);
            setState(() {

            });
              });
        }

        //todo:  success
        var sourcesList = snapshot.data?.sources??[];

          return SourceWidget(sourcesList: sourcesList);
        }


    );
  }
}
