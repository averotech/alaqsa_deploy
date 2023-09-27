

import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/news.dart';
import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable{

  const SearchEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadSearchAPIEvent extends SearchEvent {
  var _isRefresh = false;
  LoadSearchAPIEvent(this._isRefresh);

  get isRefresh => _isRefresh;
}

class UpdateTripEvent extends SearchEvent {
  Trip trip;
  UpdateTripEvent(this.trip);
}



class DetailSearchEvent extends SearchEvent {

}

