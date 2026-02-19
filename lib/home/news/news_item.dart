import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:easy_localization/easy_localization.dart';

import '../../model/news_response.dart';
import '../widget/main_loading_widget.dart';

class NewsItem extends StatelessWidget {
  final News news;

  const NewsItem({super.key, required this.news});

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

    final imageUrl = news.urlToImage;
    final timeText = timeAgoFromIso(context, news.publishedAt);

    return Container(
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
            news.title ?? '',
            style: Theme.of(context).textTheme.labelLarge,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ).tr(),

          SizedBox(height: height * 0.015),

          Row(
            children: [
              Expanded(
                child: Text(
                  news.author ?? '',
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
    );
  }
}
