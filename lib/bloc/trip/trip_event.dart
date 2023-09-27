

import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/news.dart';
import 'package:equatable/equatable.dart';

abstract class TripEvent extends Equatable{

  const TripEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadTripAPIEvent extends TripEvent {
  var _isRefresh = false;
  LoadTripAPIEvent(this._isRefresh);

  get isRefresh => _isRefresh;
}


class DetailTripEvent extends TripEvent {

}


class UpdateTripEvent extends TripEvent {
  Trip trip;
  UpdateTripEvent(this.trip);
}


class LoadTripAPINextPageEvent extends TripEvent {
  var skip;
  List<Trip> tripList;
  LoadTripAPINextPageEvent(this.skip,this.tripList);

  @override
  // TODO: implement props
  List<Object?> get props => [skip,tripList];
}

