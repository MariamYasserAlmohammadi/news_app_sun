import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import '../../../modal/sourcesResponse/Source.dart';

class CategoryDetailsViewModal extends ChangeNotifier{
  List<Source>? newsSourcesList ;
  String? errorMessage;
  bool? showLoading = false ;
  getSources(String categoryId) async{
    //call api
    showLoading =true;
    newsSourcesList =null;
    errorMessage =null;
    notifyListeners();


   try{
     var response =await ApiManager.getSources(categoryId);
     showLoading = false;
     if(response.status=='error'){
       //has error
       errorMessage = response.message;
     }else{
       //has data
       newsSourcesList = response.sources;

     }
   }catch(e){
     showLoading =false;
     errorMessage =e.toString();
   }
   notifyListeners();

}
}