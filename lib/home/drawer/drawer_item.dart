import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/utils/app_styles.dart';

class DrawerItem extends StatelessWidget {
  final String iconName;
  final String text;
  DrawerItem({required this.text,super.key, required this.iconName});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width*0.04),
      child: Row(
        spacing: width*0.04,
        children: [
        Image.asset(iconName),
          Text(text, style: AppStyles.bold20White,).tr()
        ],
      ),
    );
  }
}
