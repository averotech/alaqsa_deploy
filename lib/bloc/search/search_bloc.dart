import 'dart:async';

import 'package:alaqsa/bloc/search/search_event.dart';
import 'package:alaqsa/bloc/search/search_state.dart';
import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/repository/trips_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SearchBloc extends Bloc<SearchEvent, SearchState> {
  GlobalState globaleState = GlobalState.instance;
  SearchBloc() : super(SearchInitial(false)) {
    TripsRepository tripsRepository = TripsRepository();
    var api = Config.BaseUrl+Config.SearchTripAPI;
    var apiAuth = Config.BaseUrl+Config.SearchTripAuthAPI;
    on<LoadSearchAPIEvent>((event, emit) async{
      try{
        emit(SearchInitial(event.isRefresh));
        final prefs = await SharedPreferences.getInstance();
        var token = prefs.getString("token");
        var search = "";
        if(globaleState.get("search") != null && globaleState.get("search") != ""){
          search = globaleState.get("search");
        }
        emit(TextSearchLoaded(search));
        var dataTripsRepository = await tripsRepository.searchTrips(token.toString() != "" && token.toString() != "null"?apiAuth:api,search,token);
        List<Trip> tripList = dataTripsRepository;
        emit(SearchLoaded(tripList,event.isRefresh));
      } catch(e){
        emit(SearchErroe(e));
      }
    });

    on<UpdateTripEvent>((event, emit) async{

      event.trip.isBooking == false ? event.trip.isBooking = true:event.trip.isBooking = false;

      emit(UpdateTrips(event.trip));

    });



  }
}
