import 'dart:async';

import 'package:alaqsa/bloc/booking_page_page/booking_page_state.dart';
import 'package:alaqsa/bloc/home_page/home_page_state.dart';
import 'package:alaqsa/bloc/news/news_event.dart';
import 'package:alaqsa/bloc/news/news_state.dart';
import 'package:alaqsa/bloc/project/project_event.dart';
import 'package:alaqsa/bloc/project/project_state.dart';
import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/MYLoaction.dart';
import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/bus.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/repository/main_page_repository.dart';
import 'package:alaqsa/repository/news_repository.dart';
import 'package:alaqsa/repository/project_repository.dart';
import 'package:alaqsa/repository/trips_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/standalone.dart';

import 'booking_page_event.dart';


class BookingPageBloc extends Bloc<BookingPageEvent, BookingPageState> {
  GlobalState globaleState = GlobalState.instance;
  TripsRepository tripsRepository = TripsRepository();
  var api = Config.BaseUrl+Config.BookingTripAPI;
  var cancleBookingApi = Config.BaseUrl+Config.CancleBookingTripAPI;

  BookingPageBloc() : super(BookingPageInitial(false)) {
    on<BookingPageInitialEvent>((event, emit) async{
      var trip = globaleState.get("trip");
      var user = globaleState.get("user");
      var myLocation = globaleState.get("myAddress");
      emit(BookingPageLoaded(trip,user,myLocation));
    });

    on<BookingPageSelectedBusEvent>((event, emit) async{
      if(event.bus != null) {
        Bus selectedBus = event.bus;
        emit(BookingPageLoadedSelectedBus(selectedBus));
      }
    });

    on<BookingTripEvent>((event, emit) async {
      try {
        emit(BookingPageInitial(true));
        final prefs = await SharedPreferences.getInstance();
        var token = prefs.getString("token");
        var response = await tripsRepository.bookingTrips(
          api: api,
          token: token,
          tripId: event.tripId,
          busId: event.busId,
          numberPerson: event.numberPerson,
          numberPhone: event.numberPhone,
        );

        if (response['statusCode'] == 200) {
          emit(BookingTripLoaded(response['statusCode']));
        } else {
          emit(BookingPageErroe(response['data']['data']['message']));
        }
      } catch (e) {
        emit(BookingPageErroe(e.toString()));
      }
    });


    on<BookingTripSuccessEvent>((event, emit) {
     var trip = globaleState.get("bookingTripSuccess");
     var myAddress = globaleState.get("myAddress");
      emit(BookingTripSuccessLoaded(trip,myAddress));
    });

    on<CancleBookingTripEvent>((event, emit) async{
      try {
        emit(BookingPageInitial(false));
        final prefs = await SharedPreferences.getInstance();
        var token = prefs.getString("token");
        var responseCode = await tripsRepository.cancleBookingTrips(api:cancleBookingApi, token:token,tripId: event.tripId);

        emit(CancelBookingTripLoaded(responseCode,event.index));
      } catch(e){
        emit(BookingPageErroe(e.toString()));
      }

    });

  }
}
