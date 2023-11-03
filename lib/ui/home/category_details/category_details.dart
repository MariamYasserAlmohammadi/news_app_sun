import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/modal/category_dm.dart';
import 'package:news_app/ui/home/category_details/category_details_view_modal.dart';
import 'package:news_app/ui/home/category_details/sources_tabs-widget.dart';
import 'package:provider/provider.dart';

class CategoryDetails extends StatefulWidget {
  CategoryDM categoryDM;

  CategoryDetails(this.categoryDM, {super.key});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  var viewModal = CategoryDetailsViewModal();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModal.getSources(widget.categoryDM.id);
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> viewModal,
      child: Consumer<CategoryDetailsViewModal>(
        builder: (context,viewModal,child){
          if (viewModal.showLoading == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (viewModal.errorMessage != null) {
            Center(
              child: Column(
                children: [
                  Text(viewModal.errorMessage ?? ""),
                  ElevatedButton(
                      onPressed: () {}, child: const Text('Try Again')),
                ],
              ),
            );
          }
          var sourcesList = viewModal.newsSourcesList;
          return SourcesTabsWidget(sourcesList!);
        },),
    );

    //call api
    // return FutureBuilder(
    //     future: ApiManager.getSources(categoryDM.id),
    //     builder: (context ,snapshot){
    //       if(snapshot.connectionState == ConnectionState.waiting){
    //         return Center(child: CircularProgressIndicator(),);
    //       }
    //       else if(snapshot.hasError || snapshot.data?.status =='error'){
    //         return Center(
    //           child: Column(
    //             children: [
    //               Text(snapshot.data?.message ?? snapshot.error.toString()),
    //               ElevatedButton(onPressed: (){}, child: Text('Try Again')),
    //             ],
    //           ),
    //         );
    //       }
    //       var sourcesList = snapshot.data?.sources;
    //       return SourcesTabsWidget(sourcesList!);
    //     },);
  }
}
