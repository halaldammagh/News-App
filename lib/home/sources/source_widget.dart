import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/home/news/news_widget.dart';
import 'package:news_app/home/sources/source_tab.dart';
import 'package:news_app/model/source_response.dart';
import 'package:news_app/utils/app_colors.dart';

class SourceWidget extends StatefulWidget {
  List<Source> sourcesList;

  SourceWidget({super.key, required this.sourcesList});

  @override
  State<SourceWidget> createState() => _SourceWidgetState();
}

class _SourceWidgetState extends State<SourceWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: widget.sourcesList.length,
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(vertical: height*0.008),
            child: TabBar(
              isScrollable: true,
              dividerColor: AppColors.transParentColor,
              tabAlignment: TabAlignment.start,
              indicatorColor: Theme.of(context).splashColor,
              onTap: (index) {
                selectedIndex = index;
                setState(() {

                });

              },
              tabs: widget.sourcesList
                  .map(
                    (source) => SourceTab(
                      source: source,
                      isSelected: selectedIndex == widget.sourcesList.indexOf(source),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(child: NewsWidget(source: widget.sourcesList[selectedIndex]))
        ],
      ),
    );
  }
}
