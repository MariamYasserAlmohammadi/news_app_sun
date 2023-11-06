import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/modal/category_dm.dart';
import 'package:news_app/ui/home/category_details/category_details_view_modal.dart';
import 'package:news_app/ui/home/category_details/sources_tabs-widget.dart';

class CategoryDetails extends StatefulWidget {
  CategoryDM categoryDM;

  CategoryDetails(this.categoryDM, {super.key});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

 class _CategoryDetailsState extends State<CategoryDetails> {
  var viewModal = CategoryDetailsViewModal();

  @override
  Widget build(BuildContext context) {
    //call api
    return BlocBuilder<CategoryDetailsViewModal, CategoryDetailsState>(
      bloc: viewModal,
      builder: (context, state) {
        switch (state) {
          case SuccessState():
            {
              var sourcesList = state.sourcesList;
              return SourcesTabsWidget(sourcesList!);
            }
          case LoadingState():
            {
              return Center(
                child: Column(
                  children: [
                    Text(state.message),
                    const CircularProgressIndicator(),
                  ],
                ),
              );
            }
          case ErrorState():
            {
              return Center(
                child: Column(
                  children: [
                    Text(state.errorMessage),
                    ElevatedButton(
                        onPressed: () {
                          viewModal.loadSources(widget.categoryDM.id);
                        },
                        child: const Text('Try Again')),
                  ],
                ),
              );
            }
        }
      },
    );
    
    // FutureBuilder(
    //   future: ApiManager.getSources(categoryDM.id),
    //   builder: (context ,snapshot){
    //     if(snapshot.connectionState == ConnectionState.waiting){
    //       return Center(child: CircularProgressIndicator(),);
    //     }
    //     else if(snapshot.hasError || snapshot.data?.status =='error'){
    //       return Center(
    //         child: Column(
    //           children: [
    //             Text(snapshot.data?.message ?? snapshot.error.toString()),
    //             ElevatedButton(onPressed: (){}, child: Text('Try Again')),
    //           ],
    //         ),
    //       );
    //     }
    //     var sourcesList = snapshot.data?.sources;
    //     return SourcesTabsWidget(sourcesList!);
    //   },);
  }
}
