

import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:equatable/equatable.dart';

abstract class HomePageEvent extends Equatable{

  const HomePageEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomePageInitialEvent extends HomePageEvent {
  var _isRefresh = false;
  HomePageInitialEvent(this._isRefresh);
  get isRefresh => _isRefresh;

}
class UpdateTripEvent extends HomePageEvent {
  Trip trip;
  UpdateTripEvent(this.trip);
}

class HomePageSearchCityEvent extends HomePageEvent {

  var _search;
  HomePageSearchCityEvent(this._search);

  get search => _search;
}

