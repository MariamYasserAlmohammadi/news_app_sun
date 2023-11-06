import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/ui/home/news/news_view_modal.dart';
import 'package:news_app/ui/home/news/news_widget.dart';

import '../../../modal/sourcesResponse/Source.dart';

class NewsListWidget extends StatefulWidget {
  Source source;

  NewsListWidget(this.source, {super.key});

  @override
  State<NewsListWidget> createState() => _NewsListWidgetState();
}

class _NewsListWidgetState extends State<NewsListWidget> {
  var viewModel = NewsListViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.loadNews(widget.source.id);
  }

  @override
  Widget build(BuildContext context) {
    //call Api
    return BlocBuilder<NewsListViewModel, NewsListState>(
      bloc: viewModel,
      builder: (context, state) {
        switch (state) {
          case SuccessState():
            {
              var newsList = state.newsList;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return NewsWidget(newsList![index]);
                },
                itemCount: newsList?.length ?? 0,
              );
            }
          case ErrorState():
            {
              return Center(
                child: Column(
                  children: [
                    Text(state.errorMessage),
                    ElevatedButton(onPressed: () {
                      viewModel.loadNews(widget.source.id);
                    }, child: const Text('Try Again'))
                  ],
                ),
              );
            }
          case LoadingState():
            {
              return const Center(child: CircularProgressIndicator());
            }
        }
      },
    );

    //   FutureBuilder(
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
    //               ElevatedButton(onPressed: (){}, child: Text("Try Again"))
    //             ],
    //           ),
    //         );
    //       }
    //      var newsList =snapshot.data?.articles;
    //       return ListView.builder(
    //         itemBuilder: (context, index) {
    //           return NewsWidget(newsList![index]);
    //         },
    //         itemCount: newsList?.length??0,
    //       );
    //     }
    // );
  }
}
