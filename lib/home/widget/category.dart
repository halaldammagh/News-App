import 'package:news_app/utils/app_assets.dart';

class Category {
  String id;
  String title;
  String image;
  bool isRight;


  Category({required this.id, required this.title, required this.image, this.isRight = false});


  static List<Category> getCategoriesList (bool isDark){
    return [
      Category(isRight: true, id: 'general', title: 'General', image: isDark?AppAssets.generalLight:AppAssets.generalDark, ),
      Category(id: 'business', title: 'Business', image: isDark?AppAssets.businessLight:AppAssets.businessDark),
      Category(isRight: true,id: 'sports', title: 'Sports', image: isDark?AppAssets.sportLight:AppAssets.sportDark, ),
      Category(id: 'health', title: 'Health', image: isDark?AppAssets.healthLight:AppAssets.healthDark),
      Category(isRight: true,id: 'entertainment', title: 'Entertain', image: isDark?AppAssets.entertainmentLight:AppAssets.entertainmentDark),
      Category(id: 'technology', title: 'Technology', image: isDark?AppAssets.technologyLight:AppAssets.technologyDark),
      Category(isRight: true,id: 'science', title: 'Science', image: isDark?AppAssets.scienceLight:AppAssets.scienceDark),

    ];
  }
}