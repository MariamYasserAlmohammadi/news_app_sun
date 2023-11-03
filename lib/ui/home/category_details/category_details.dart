import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/modal/category_dm.dart';
import 'package:news_app/ui/home/category_details/sources_tabs-widget.dart';




class CategoryDetails extends StatelessWidget {
  CategoryDM categoryDM;
  CategoryDetails(this.categoryDM,{super.key});

  @override
  Widget build(BuildContext context) {
    //call api
    return FutureBuilder(
        future: ApiManager.getSources(categoryDM.id),
        builder: (context ,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.hasError || snapshot.data?.status =='error'){
            return Center(
              child: Column(
                children: [
                  Text(snapshot.data?.message ?? snapshot.error.toString()),
                  ElevatedButton(onPressed: (){}, child: Text('Try Again')),
                ],
              ),
            );
          }
          var sourcesList = snapshot.data?.sources;
          return SourcesTabsWidget(sourcesList!);
        },);

  }
}
