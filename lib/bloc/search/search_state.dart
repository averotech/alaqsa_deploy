import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/news.dart';
import 'package:equatable/equatable.dart';


abstract class SearchState extends Equatable{
  const SearchState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {
  @override
  var isRefresh;
  SearchInitial(this.isRefresh);
  // TODO: implement props
  List<Object?> get props => [isRefresh];
}


class SearchLoaded extends SearchState {
  final List<Trip> tripList;
  var isRefresh;
  SearchLoaded(this.tripList,this.isRefresh);

  @override
  // TODO: implement props
  List<Object?> get props => [tripList,isRefresh];
}

class UpdateTrips extends SearchState {
  Trip trip;
  UpdateTrips(this.trip);

  @override
  // TODO: implement props
  List<Object?> get props => [trip];
}

class TextSearchLoaded extends SearchState {
  var textSearch;

  TextSearchLoaded(this.textSearch);

  @override
  // TODO: implement props
  List<Object?> get props => [textSearch];
}



class SearchErroe extends SearchState {
  final error;
  SearchErroe(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}


