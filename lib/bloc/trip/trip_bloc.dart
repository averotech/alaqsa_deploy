import 'dart:async';

import 'package:alaqsa/bloc/news/news_event.dart';
import 'package:alaqsa/bloc/news/news_state.dart';
import 'package:alaqsa/bloc/trip/trip_event.dart';
import 'package:alaqsa/bloc/trip/trip_state.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/repository/news_repository.dart';
import 'package:alaqsa/repository/trips_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TripBloc extends Bloc<TripEvent, TripState> {

  TripBloc() : super(TripInitial(false)) {
    TripsRepository tripsRepository = TripsRepository();
    var api = Config.BaseUrl+Config.TripsAPI;
    var apiAuth = Config.BaseUrl+Config.TripsAuthAPI;
    on<LoadTripAPIEvent>((event, emit) async{
      try{
        emit(TripInitial(event.isRefresh));
        final prefs = await SharedPreferences.getInstance();
        var token = prefs.getString("token");
        var dataTripsRepository = await tripsRepository.getTrips(token.toString() != "" && token.toString() != "null"?apiAuth:api,0,token);
        List<Trip> tripList = dataTripsRepository;
        emit(SkipTrips(0));
        emit(TripLoaded(tripList,event.isRefresh));
      } catch(e){
        emit(TripErroe(e));
      }
    });

    on<LoadTripAPINextPageEvent>((event, emit) async{
      emit(TripInitial(false));
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var dataNewsRepository = await tripsRepository.getTrips(token.toString() != "" && token != "null"?apiAuth:api,event.skip,token);
      List<Trip> tripList = event.tripList+dataNewsRepository;

      if(dataNewsRepository.isNotEmpty){
        emit(SkipTrips(event.skip));
      } else {
        emit(SkipTrips(event.skip-10));
      }

      emit(TripLoaded(tripList,false));
    });


    on<UpdateTripEvent>((event, emit) async{

      event.trip.isBooking == false ? event.trip.isBooking = true:event.trip.isBooking = false;

      emit(UpdateTrips(event.trip));

    });

  }
}
