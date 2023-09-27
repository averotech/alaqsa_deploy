import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/models/project.dart';
import 'package:equatable/equatable.dart';


abstract class BookingPageState extends Equatable{
  const BookingPageState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BookingPageInitial extends BookingPageState {
  @override
  var isRefresh;
  BookingPageInitial(this.isRefresh);
  // TODO: implement props
  List<Object?> get props => [isRefresh];
}


class BookingPageLoaded extends BookingPageState {
  var trip;
  var user;
  var myLocation;
  BookingPageLoaded(this.trip,this.user,this.myLocation);

  @override
  // TODO: implement props
  List<Object?> get props => [trip,user,myLocation];
}


class BookingPageLoadedSelectedBus extends BookingPageState {
  var bus;
  BookingPageLoadedSelectedBus(this.bus);

  @override
  // TODO: implement props
  List<Object?> get props => [bus];
}


class BookingTripLoaded extends BookingPageState {
  var responseCode;
  BookingTripLoaded(this.responseCode);

  @override
  // TODO: implement props
  List<Object?> get props => [responseCode];
}

class CancelBookingTripLoaded extends BookingPageState {
  var responseCode;
  var index;
  CancelBookingTripLoaded(this.responseCode,this.index);

  @override
  // TODO: implement props
  List<Object?> get props => [responseCode,index];
}


class BookingTripSuccessLoaded extends BookingPageState {
  var trip;
  var myAddrees;
  BookingTripSuccessLoaded(this.trip,this.myAddrees);

  @override
  // TODO: implement props
  List<Object?> get props => [trip,myAddrees];
}


class BookingPageSearchLoaded extends BookingPageState {
  BookingPageSearchLoaded();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class BookingPageSearchError extends BookingPageState {
  final error;
  BookingPageSearchError(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}


class BookingPageErroe extends BookingPageState {
  final error;
  BookingPageErroe(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}


