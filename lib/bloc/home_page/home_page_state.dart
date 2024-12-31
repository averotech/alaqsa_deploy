import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/models/project.dart';
import 'package:equatable/equatable.dart';


abstract class HomePageState extends Equatable{
  const HomePageState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomePageInitial extends HomePageState {
  @override
  var isRefresh;
  HomePageInitial(this.isRefresh);
  // TODO: implement props
  List<Object?> get props => [isRefresh];
}


class HomePageLoaded extends HomePageState {
  var trip;
  List<News> listNews;
  var isRefresh;
  var apkSettings;
  HomePageLoaded(this.trip,this.listNews,this.isRefresh, this.apkSettings);

  @override
  // TODO: implement props
  List<Object?> get props => [trip,listNews,isRefresh];
}

class HomePageAutoCompleteLoaded extends HomePageState {
  List autoComplete;
  HomePageAutoCompleteLoaded(this.autoComplete);

  @override
  // TODO: implement props
  List<Object?> get props => [autoComplete];
}


class UpdateTrips extends HomePageState {
  Trip trip;
  UpdateTrips(this.trip);

  @override
  // TODO: implement props
  List<Object?> get props => [trip];
}


class HomePageSearchLoaded extends HomePageState {
  HomePageSearchLoaded();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class HomePageSearchError extends HomePageState {
  final error;
  HomePageSearchError(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}


class HomePageErroe extends HomePageState {
  final error;
  HomePageErroe(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}


