import 'dart:async';

import 'package:alaqsa/bloc/news/news_event.dart';
import 'package:alaqsa/bloc/news/news_state.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/repository/news_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


class NewsBloc extends Bloc<NewsEvent, NewsState> {

  NewsBloc() : super(NewsInitial(false)) {
    NewsRepository newsRepository = NewsRepository();
    var api = Config.BaseUrl+Config.NewsAPI;
    on<LoadNewsAPIEvent>((event, emit) async{
      try{
        emit(NewsInitial(event.isRefresh));
        var dataNewsRepository = await newsRepository.getNews(api);
        List<News> newsList = dataNewsRepository[0];
        var nextPageUrl = dataNewsRepository[1];
        emit(NewsFoundNextPages(nextPageUrl));
        emit(NewsLoaded(newsList,event.isRefresh));
      } catch (e){
        emit(NewsErroe(e));
      }

    });

    on<LoadNewsAPINextPageEvent>((event, emit) async{
      emit(NewsInitial(false));
      var dataNewsRepository = await newsRepository.getNews(event.nextPageUrl);
      List<News> newsList = event.newsList+dataNewsRepository[0];
      var nextPageUrl = dataNewsRepository[1];
      emit(NewsFoundNextPages(nextPageUrl));
      emit(NewsLoaded(newsList,false));
    });
    on<DetailNewsEvent>((event,emit) async{
      News news = newsRepository.getDetailNews();
      emit(DetailNewsState(news));
    });
  }
}
