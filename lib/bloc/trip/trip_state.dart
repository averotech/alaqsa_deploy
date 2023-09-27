import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/news.dart';
import 'package:equatable/equatable.dart';


abstract class TripState extends Equatable{
  const TripState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TripInitial extends TripState {
  @override
  var isRefresh;
  TripInitial(this.isRefresh);
  // TODO: implement props
  List<Object?> get props => [isRefresh];
}


class TripLoaded extends TripState {
  final List<Trip> tripList;
  var isRefresh;
  TripLoaded(this.tripList,this.isRefresh);

  @override
  // TODO: implement props
  List<Object?> get props => [tripList,isRefresh];
}


class SkipTrips extends TripState {
  final skip;
  SkipTrips(this.skip);

  @override
  // TODO: implement props
  List<Object?> get props => [skip];
}

class UpdateTrips extends TripState {
  Trip trip;
  UpdateTrips(this.trip);

  @override
  // TODO: implement props
  List<Object?> get props => [trip];
}

class DetailTripState extends TripState{
  News news;
  DetailTripState(this.news);

  @override
  // TODO: implement props
  List<Object?> get props => [news];
}

class TripErroe extends TripState {
  final error;
  TripErroe(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}


