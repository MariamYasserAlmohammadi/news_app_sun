import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';

import '../../../modal/newsResponse/news.dart';

class NewsListViewModal extends ChangeNotifier{
  bool? showLoading =false;
  List<News>? newsList;
  String? errorMessage;

  getNews(String sourceId) async{
    showLoading =true;
    newsList =null;
    errorMessage = null;
    notifyListeners();

   try {
     var response = await ApiManager.getNews(sourceId);
     showLoading =false;
     if (response.status == 'error') {
       errorMessage = response.message;
     } else {
       newsList = response.articles;
     }
   }catch(e){
     showLoading =false;
     errorMessage =e.toString();
   }
   notifyListeners();


  }

}