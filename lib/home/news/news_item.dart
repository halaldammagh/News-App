import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/providers/app_language_provider.dart';
import 'package:news_app/providers/app_theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:easy_localization/easy_localization.dart';
import 'package:news_app/home/news/news_web_view.dart';
import '../../model/news_response.dart';
import '../widget/main_loading_widget.dart';

class NewsItem extends StatefulWidget {
  final News news;

  const NewsItem({super.key, required this.news});

  @override
  State<NewsItem> createState() => _NewsItemState();
}


class _NewsItemState extends State<NewsItem> {
  String timeAgoFromIso(BuildContext context, String? iso) {
    if (iso == null || iso.isEmpty) return '';
    final date = DateTime.parse(iso).toLocal();
    final currentLang = context.locale.languageCode;
    return timeago.format(date, locale: currentLang);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var  themeProvider = Provider.of<AppThemeProvider>(context);
    var  languageProvider = Provider.of<AppLanguageProvider>(context);
    final imageUrl = widget.news.urlToImage;
    final timeText = timeAgoFromIso(context, widget.news.publishedAt);
    final description = widget.news.description;
    String content = widget.news.content ?? '';


    RegExp regExp = RegExp(r'\[\+(\d+)\schars\]');
    Match? match = regExp.firstMatch(content);
    int extraChars = 0;
    if (match != null) {
      extraChars = int.parse(match.group(1)!);
    }
    String cleanContent =
    content.replaceAll(RegExp(r'\[\+\d+\schars\]'), '').trim();
    int totalLength = cleanContent.length + extraChars;



    Future<void> openUrl(String url) async {
      final Uri uri = Uri.parse(url);

      if (!await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) {
        throw Exception('Could not launch $url');
      }
    }

    return InkWell(
      onTap:(){
        showBottomSheet(
          backgroundColor: Colors.transparent, // مهم
          context: context, builder: (context) {
           return Padding(
             padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.02),
             child: Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(12),
                 color:themeProvider.isDarkMode()? AppColors.whiteColor:AppColors.blackColor
               ),
               height:height*0.424 ,

               child:Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: SingleChildScrollView(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                       ClipRRect(
                         borderRadius: BorderRadius.circular(12),
                         child: (imageUrl == null || imageUrl.isEmpty)
                             ? Container(
                           height: height * 0.22,
                           width: double.infinity,
                           alignment: Alignment.center,
                           child: const Icon(Icons.image_not_supported),
                         )
                             : CachedNetworkImage(
                           imageUrl: imageUrl,
                           height: height * 0.22,
                           width: double.infinity,
                           fit: BoxFit.cover,
                           placeholder: (context, url) =>
                           const Center(child: MainLoadingWidget()),
                           errorWidget: (context, url, error) =>
                           const Icon(Icons.error),
                         ),
                       ),
                       Padding(
                         padding: EdgeInsets.symmetric(vertical:height*0.01),
                         child: Text.rich(
                           maxLines: 5,
                             style: Theme.of(context).textTheme.bodyMedium,
                             TextSpan(text: description??'',
                         children: [
                           TextSpan(text: '.. \n[+${totalLength} chars]'),

                         ]
                         )),
                       ),
                       SizedBox(height: height*0.02,),
                       ElevatedButton(
                           style:ElevatedButton.styleFrom(
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(8),
                             ),
                             padding: EdgeInsets.symmetric(vertical: 20),
                             backgroundColor: themeProvider.isDarkMode()?AppColors.blackColor:AppColors.whiteColor

                           ),
                           onPressed:(){
                             final url = widget.news.url;
                             if (url == null || url.trim().isEmpty) return;
                             Navigator.pop(context);

                             Navigator.push(
                               context,
                               MaterialPageRoute(
                                 builder: (_) => NewsWebView(url: url),
                               ),
                             );


                           }, child: Text('View Full Articel',style: Theme.of(context).textTheme.labelLarge,))

                     ],
                   ),
                 ),
               ),
             ),
           );
        },);
      },
      child: Container(

        padding: EdgeInsets.symmetric(
          horizontal: width * 0.03,
          vertical: height * 0.015,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.01,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 2,
            color: Theme.of(context).dividerColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: (imageUrl == null || imageUrl.isEmpty)
                  ? Container(
                height: height * 0.22,
                width: double.infinity,
                alignment: Alignment.center,
                child: const Icon(Icons.image_not_supported),
              )
                  : CachedNetworkImage(
                imageUrl: imageUrl,
                height: height * 0.22,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                const Center(child: MainLoadingWidget()),
                errorWidget: (context, url, error) =>
                const Icon(Icons.error),
              ),
            ),

            SizedBox(height: height * 0.02),

            Text(
              widget.news.title ?? '',
              style: Theme.of(context).textTheme.labelLarge,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ).tr(),

            SizedBox(height: height * 0.015),

            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.news.author ?? '',
                    style: Theme.of(context).textTheme.labelSmall,
                    overflow: TextOverflow.ellipsis,
                  ).tr(),
                ),
                const SizedBox(width: 8),
                Text(
                  timeText,
                  style: Theme.of(context).textTheme.labelSmall,
                ).tr(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
