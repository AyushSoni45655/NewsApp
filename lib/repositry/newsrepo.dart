import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_news_app/model/news_channel_headline_model.dart';

class NewsRepositry {
  Future<NewsChannelHeadlineModel> fetchNewsCjannelHedaline(String category) async {
    String url =
        'https://newsapi.org/v2/everything?q=${category}&apiKey=d50118ad0b174edb9099afe101d2d31f';
    final responce = await http.get(Uri.parse(url));
    if(kDebugMode){
      print(responce.body);
    }
    if (responce.statusCode == 200) {
      final body = jsonDecode(responce.body);
      return NewsChannelHeadlineModel.fromJson(body);
    }
    throw Exception('error');
  }
}
