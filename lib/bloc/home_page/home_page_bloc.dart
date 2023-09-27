import 'dart:async';

import 'package:alaqsa/bloc/home_page/home_page_state.dart';
import 'package:alaqsa/bloc/news/news_event.dart';
import 'package:alaqsa/bloc/news/news_state.dart';
import 'package:alaqsa/bloc/project/project_event.dart';
import 'package:alaqsa/bloc/project/project_state.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/MYLoaction.dart';
import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/bus.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/repository/main_page_repository.dart';
import 'package:alaqsa/repository/news_repository.dart';
import 'package:alaqsa/repository/project_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/standalone.dart';

import 'home_page_event.dart';


class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {

  HomePageBloc() : super(HomePageInitial(false)) {
    NewsRepository newsRepository = NewsRepository();
    MainPageRepository mainPageRepository = MainPageRepository();
    var api = Config.BaseUrl+Config.NewsAPI;
    var nearTripApi = Config.BaseUrl+Config.NearTripAPI;
    var nearTripAuthApi = Config.BaseUrl+Config.NearTripAuthAPI;
    var autoCompleteSearchTripApi = Config.BaseUrl+Config.AutoCompleteSearchTripAPI;
    on<HomePageInitialEvent>((event, emit) async{

      try{
        emit(HomePageInitial(event.isRefresh));
        var dataNewsRepository = await newsRepository.getNews(api);
        List<News> newsList = dataNewsRepository[0];
        final prefs = await SharedPreferences.getInstance();
        var token = prefs.getString("token");
        var nearTrip = await mainPageRepository.getNearTripAndBokkingTrip(api: token.toString() != "" && token.toString() != "null"? nearTripAuthApi :nearTripApi,token: token);
        emit(HomePageLoaded(nearTrip,newsList,event.isRefresh));
      }catch(e){
        emit(HomePageErroe(e));
      }

    });

    on<HomePageSearchCityEvent>((event, emit) async{

      if(event.search != "") {
        List autoComplete = await mainPageRepository.autoCompleteSearch(api: autoCompleteSearchTripApi,search: event.search);
        emit(HomePageAutoCompleteLoaded(autoComplete));
      }


    });

    on<UpdateTripEvent>((event, emit) async{

      event.trip.isBooking == false ? event.trip.isBooking = true:event.trip.isBooking = false;

      emit(UpdateTrips(event.trip));

    });

  }
}
