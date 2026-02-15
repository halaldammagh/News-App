import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_app/home/widget/category.dart';
import 'package:news_app/providers/app_theme_provider.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_styles.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  Category category;
  bool isRight;
   CategoryItem({super.key, required this.category,  this.isRight = false});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(

      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child:  Image.asset(category.image),
          ),
             Container(
               width: double.infinity,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: category.isRight?width*0.52:width*0.02,top: height*0.046),
                    child: Text(category.title,style:Theme.of(context).textTheme.bodyLarge,).tr(),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top:height*0.05 ,left: category.isRight?width*0.52:width*0.02, ),
                    child: Container(
                      padding: EdgeInsetsDirectional.only(
                        start: category.isRight?width*0.02:0,
                        end: category.isRight?0:width*0.02
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(84),
                        color: AppColors.greyColor
                      ),
                      child: category.isRight?

                        Row(
                          spacing: width*0.04,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('View All', style: Theme.of(context).textTheme.headlineMedium,).tr(),
                            CircleAvatar(
                              backgroundColor:Theme.of(context).primaryColor ,

                              radius: 30,
                              child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios,color:Theme.of(context).splashColor)),
                            )
                          ],
                        ):

                        Row(
                          spacing: width*0.04,

                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              backgroundColor:Theme.of(context).primaryColor ,
                              radius: 30,
                              child: IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.arrow_back_ios,color:Theme.of(context).splashColor)),
                            ),
                            Text('View All', style: Theme.of(context).textTheme.headlineMedium,).tr(),

                          ],
                        ),
                      )
                    ),

                ],
                           ),
             ),


        ],
      ),
    );
  }
}
