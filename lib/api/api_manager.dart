import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/modal/newsResponse/NewsResponse.dart';
import 'package:news_app/modal/sourcesResponse/SourcesResponse.dart';
class ApiManager{
  static const baseUrl ='newsapi.org';
  static const apiKey ='e3b90a9b42bd43d8b8319fa7985232e9';
  static Future <SourcesResponse> getSources(String categoryId) async{
    var uri =Uri.https(baseUrl,
        'v2/top-headlines/sources',{
          "apiKey": apiKey,
          "category":categoryId,

        });
    var response =await http.get(uri);
    // decode to json
    var json =jsonDecode(response.body);
    // object
    var sourcesResponse =SourcesResponse.fromJson(
      json);
    return sourcesResponse;

  }
  static Future<NewsResponse> getNews(String? sourceId)async{
    var url =Uri.https(baseUrl,"v2/everything",{
      "apiKey":apiKey,
    "sources":sourceId,
    });
    var response =await http.get(url);
    var json = jsonDecode(response.body);
    var newsResponse =NewsResponse.fromJson(json);
    return newsResponse;

  }
}