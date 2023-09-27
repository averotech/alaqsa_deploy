

import 'package:alaqsa/models/news.dart';
import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable{

  const NewsEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadNewsAPIEvent extends NewsEvent {
  var _isRefresh = false;
  LoadNewsAPIEvent(this._isRefresh);

  get isRefresh => _isRefresh;
}


class DetailNewsEvent extends NewsEvent {

}


class LoadNewsAPINextPageEvent extends NewsEvent {
  var nextPageUrl;
  List<News> newsList;
  LoadNewsAPINextPageEvent(this.nextPageUrl,this.newsList);

  @override
  // TODO: implement props
  List<Object?> get props => [nextPageUrl,newsList];
}

