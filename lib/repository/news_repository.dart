
import 'dart:convert';

import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/news.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/standalone.dart' as tz;
import 'package:intl/intl.dart';

class NewsRepository {

  GlobalState globalState = GlobalState.instance;

  getNews(api) async{
    List<News> newsList = <News>[];
    try {
      var response = await http.get(Uri.parse(api));


      if(response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var data = jsonResponse["data"]["data"];
        var nextPage = jsonResponse["data"]["next_page_url"];
        if(data.isNotEmpty) {
          for(var i=0;i<data.length;i++){
            DateTime dtf = DateTime.parse(data[i]["created_at"]);
            var d = DateFormat.d('en');
            var y = DateFormat.y('en');
            var m = DateFormat.M("en");//DateFormat('dd MM yyyy');
            var dDate = d.format(dtf);
            var yDate = y.format(dtf);
            var mDate = m.format(dtf);
            var date = dDate+"/"+mDate+"/"+yDate;
            News news = News.fromJson(data[i]);
            news.date = date;
            newsList.add(news);
          }

          if(nextPage != null && nextPage.toString() != null) {
            return [newsList,nextPage];
          } else {
            return [newsList,"null"];
          }

        }
      }
    } catch(e) {
      print(e.toString());
      return [newsList,"null"];
    }
  }

  getDetailNews(){
    if(globalState.get("news") != null) {
      News news = globalState.get("news");
      return news;
    }
    return null;

  }

}