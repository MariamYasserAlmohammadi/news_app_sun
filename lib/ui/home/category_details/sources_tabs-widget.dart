import 'package:flutter/material.dart';
import 'package:news_app/ui/home/category_details/tab_widget.dart';
import 'package:news_app/ui/home/news/news_list_widget.dart';

import '../../../modal/sourcesResponse/Source.dart';



class SourcesTabsWidget extends StatefulWidget {
  List<Source> sources;

  SourcesTabsWidget(this.sources, {super.key});

  @override
  State<SourcesTabsWidget> createState() => _SourcesTabsWidgetState();
}

class _SourcesTabsWidgetState extends State<SourcesTabsWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.sources.length,
      child: Column(
        children: [
          const SizedBox(height: 8,),
          TabBar(
            indicatorColor: Colors.transparent,
              onTap: (newIndex) {
                selectedIndex = newIndex;
                setState(() {});
              },
              isScrollable: true,
              tabs: widget.sources
                  .map((source) => TabWidget(source,
                  widget.sources.indexOf(source)==selectedIndex)).toList()),
          NewsListWidget(widget.sources[selectedIndex]),
        ],
      ),
    );
  }
}
