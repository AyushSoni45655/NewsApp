import 'package:my_news_app/model/news_channel_headline_model.dart';
import 'package:my_news_app/repositry/newsrepo.dart';

class NewsViewModel{
  final _rep  =  NewsRepositry();
  Future<NewsChannelHeadlineModel> fetchNewsCjannelHedaline(String category)async{
final responce = await _rep.fetchNewsCjannelHedaline(category);
return responce;
  }

}