import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/app_assets.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_styles.dart';

class SelectedItem extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const SelectedItem({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      margin:EdgeInsets.symmetric(horizontal: width*0.04) ,
      padding: EdgeInsets.symmetric(vertical: height*0.01, horizontal: width*0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.whiteColor,
          width: 2
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: AppStyles.medium20White,).tr(),
          InkWell(
              onTap: onPressed,
              child: Image.asset(AppAssets.showIcon))
        ],
      ),
    );
  }
}
