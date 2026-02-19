import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/providers/app_language_provider.dart';
import 'package:news_app/providers/app_theme_provider.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  String? selectedValue;

  final List<String> items = ['english', 'arabic'];

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedValue,
        hint: const SizedBox.shrink(),
        // لا يظهر نص
        isDense: true,

        // icon: Icon(
        //   Icons.arrow_forward_ios,
        //   size: 30,
        //   color: themeProvider.isDarkMode()
        //       ? AppColors.mainDarkMode
        //       : AppColors.mainColor,
        // ),

        ///  عناصر القائمة
        items: items.map((e) {
          final String label = (e == 'arabic')
              ? 'العربية'
              : 'English';
          return DropdownMenuItem<String>(
            value: e,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        }).toList(),

        ///  يخفي النص المختار بجانب السهم حتى بعد الاختيار
        selectedItemBuilder: (context) {
          return items.map((e) => const SizedBox.shrink()).toList();
        },

        ///  هنا تغيير اللغة فعليًا
        onChanged: (value) async {
          if (value == null) return;

          setState(() => selectedValue = value);

          await languageProvider.changeLanguage(
            context,
            value == 'arabic' ? 'ar' : 'en',
          );
        },
      ),
    );
  }
}
