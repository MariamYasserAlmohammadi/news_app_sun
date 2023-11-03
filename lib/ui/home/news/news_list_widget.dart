import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/ui/home/news/news_widget.dart';

import '../../../modal/sourcesResponse/Source.dart';

class NewsListWidget extends StatelessWidget {
  Source source;

  NewsListWidget(this.source, {super.key});




  @override
  Widget build(BuildContext context) {
    //call Api
    return FutureBuilder(
        future: ApiManager.getNews(source.id),
        builder: (context ,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else if(snapshot.data?.status =='error'||snapshot.hasError ){
            return Center(
              child: Column(
                children: [
                  Text(snapshot.data?.message ?? snapshot.error.toString()),
                  ElevatedButton(onPressed: (){}, child: Text("Try Again"))
                ],
              ),
            );
          }
         var newsList =snapshot.data?.articles;
          return ListView.builder(
            itemBuilder: (context, index) {
              return NewsWidget(newsList![index]);
            },
            itemCount: newsList?.length??0,
          );
        }
    );

  }
}
