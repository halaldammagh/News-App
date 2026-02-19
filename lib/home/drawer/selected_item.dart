import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/app_assets.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_styles.dart';

class SelectedItem<T> extends StatelessWidget {
  final String text; // النص المعروض (English / Dark)
  final List<PopupMenuEntry<T>> items; // عناصر المنيو
  final ValueChanged<T> onSelected; // لما يختار عنصر

  const SelectedItem({
    super.key,
    required this.text,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.04),
      padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.whiteColor, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: AppStyles.medium20White).tr(),

          PopupMenuButton<T>(
            onSelected: onSelected,
            itemBuilder: (_) => items,
            padding: EdgeInsets.zero,
            color: AppColors.blackColor, // لون المنيو
            child: SizedBox(
              width: width * 0.08,
              height: width * 0.08,
              child: Center(
                child: Image.asset(
                  AppAssets.showIcon,
                  width: width * 0.06,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
