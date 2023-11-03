import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/ui/home/news/news_list_view_modal.dart';
import 'package:news_app/ui/home/news/news_widget.dart';
import 'package:provider/provider.dart';

import '../../../modal/sourcesResponse/Source.dart';

class NewsListWidget extends StatefulWidget {
  Source source;

  NewsListWidget(this.source, {super.key});

  @override
  State<NewsListWidget> createState() => _NewsListWidgetState();
}

class _NewsListWidgetState extends State<NewsListWidget> {
  var viewModal = NewsListViewModal();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModal.getNews(widget.source.id ?? "");
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModal,
      child: Consumer<NewsListViewModal>(builder: (context, viewModal, child) {
        if (viewModal.showLoading == true) {
          return const Center(child: CircularProgressIndicator());
        } else if (viewModal.errorMessage != null) {
          return Center(
            child: Column(
              children: [
                Text(viewModal.errorMessage ?? ""),
                ElevatedButton(onPressed: () {
                  viewModal.getNews(widget.source.id??"");
                }, child: const Text("Try Again"))
              ],
            ),
          );
        }
        var newsList = viewModal.newsList;
        return Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return NewsWidget(newsList![index]);
            },
            itemCount: newsList?.length ?? 0,
          ),
        );
      }),
    );

    //call Api
    // return FutureBuilder(
    //     future: ApiManager.getNews(source.id),
    //     builder: (context ,snapshot){
    //       if(snapshot.connectionState == ConnectionState.waiting){
    //         return Center(child: CircularProgressIndicator());
    //       }
    //       else if(snapshot.data?.status =='error'||snapshot.hasError ){
    //         return Center(
    //           child: Column(
    //             children: [
    //               Text(snapshot.data?.message ?? snapshot.error.toString()),
    //               ElevatedButton(onPressed: (){}, child: const Text("Try Again"))
    //             ],
    //           ),
    //         );
    //       }
    //      var newsList =snapshot.data?.articles;
    //       return Expanded(
    //         child: ListView.builder(
    //           itemBuilder: (context, index) {
    //             return NewsWidget(newsList![index]);
    //           },
    //           itemCount: newsList?.length??0,
    //         ),
    //       );
    //     }
    // );
  }
}
