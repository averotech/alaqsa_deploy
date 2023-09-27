import 'package:alaqsa/models/news.dart';
import 'package:equatable/equatable.dart';


abstract class NewsState extends Equatable{
  const NewsState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {
  @override
  var isRefresh;
  NewsInitial(this.isRefresh);
  // TODO: implement props
  List<Object?> get props => [isRefresh];
}


class NewsLoaded extends NewsState {
  final List<News> newsList;
  var isRefresh;
  NewsLoaded(this.newsList,this.isRefresh);

  @override
  // TODO: implement props
  List<Object?> get props => [newsList,isRefresh];
}


class NewsFoundNextPages extends NewsState {
  final nextPageUrl;
  NewsFoundNextPages(this.nextPageUrl);

  @override
  // TODO: implement props
  List<Object?> get props => [nextPageUrl];
}


class DetailNewsState extends NewsState{
  News news;
  DetailNewsState(this.news);

  @override
  // TODO: implement props
  List<Object?> get props => [news];
}

class NewsErroe extends NewsState {
  final error;
  NewsErroe(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}


