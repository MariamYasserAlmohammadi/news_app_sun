import 'dart:html';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api/api_manager.dart';
import '../../../modal/sourcesResponse/Source.dart';

class CategoryDetailsViewModal extends Cubit<CategoryDetailsState> {
  // super constructor take initial state ;
  CategoryDetailsViewModal() :super(LoadingState("Loading"));

  void loadSources(String categoryId) async{
    //as notifyListener
    emit(LoadingState('Loading...'));
    //call Api
    try{
      var response = await ApiManager.getSources(categoryId);
      if(response.status=='error'){
        emit(ErrorState(response.message ?? ""));
      }else{
        emit(SuccessState(response.sources));
      }
    }catch(e){
      emit(ErrorState(e.toString()));
    }
  }
}
 sealed class CategoryDetailsState{

}

class SuccessState extends CategoryDetailsState{
List<Source>? sourcesList;
SuccessState(this.sourcesList);
}
class LoadingState extends CategoryDetailsState{
  String message;
  LoadingState(this.message);
}
class ErrorState extends CategoryDetailsState{
  String errorMessage;
  ErrorState(this.errorMessage);
}