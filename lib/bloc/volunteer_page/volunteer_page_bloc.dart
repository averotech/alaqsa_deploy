import 'dart:async';

import 'package:alaqsa/bloc/donation_page/donation_page_event.dart';
import 'package:alaqsa/bloc/donation_page/donation_page_state.dart';
import 'package:alaqsa/bloc/home_page/home_page_state.dart';
import 'package:alaqsa/bloc/news/news_event.dart';
import 'package:alaqsa/bloc/news/news_state.dart';
import 'package:alaqsa/bloc/project/project_event.dart';
import 'package:alaqsa/bloc/project/project_state.dart';
import 'package:alaqsa/bloc/volunteer_page/volunteer_page_event.dart';
import 'package:alaqsa/bloc/volunteer_page/volunteer_page_state.dart';
import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/MYLoaction.dart';
import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/bus.dart';
import 'package:alaqsa/models/donatione.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/repository/donation_repository.dart';
import 'package:alaqsa/repository/main_page_repository.dart';
import 'package:alaqsa/repository/news_repository.dart';
import 'package:alaqsa/repository/project_repository.dart';
import 'package:alaqsa/repository/trips_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/standalone.dart';


class VolunteerPageBloc extends Bloc<VolunteerPageEvent, VolunteerPageState> {
  GlobalState globaleState = GlobalState.instance;
  ProjectRepository projectRepository = ProjectRepository();
  var api = Config.BaseUrl+Config.VoluntterAPI;
  var cancleVolunteer = Config.BaseUrl+Config.CancleVoluntterAPI;

  VolunteerPageBloc() : super(VolunteerPageInitial()) {
    on<VolunteerPageInitialEvent>((event, emit) async{
      var project = globaleState.get("volunteerProject");
      var user = globaleState.get("user");
      var myAddress = globaleState.get("myAddress");
      emit(VolunteerPageLoaded(project,user,myAddress));

    });

    on<VolunteerPageRequestApiEvent>((event, emit) async{
      try {
        emit(VolunteerPageInitial());
        final prefs = await SharedPreferences.getInstance();
        var token = prefs.getString("token");
        var responseCode = await projectRepository.volunteer(api: api,token: token,id: event.projectId);
        emit(VolunteerRequestApiLoaded(responseCode));
      } catch(e){
        emit(VolunteerPageErroe(e.toString()));
      }

    });


    on<CancleVolunteerPageRequestApiEvent>((event, emit) async{
      try {
        emit(VolunteerPageInitial());
        final prefs = await SharedPreferences.getInstance();
        var token = prefs.getString("token");
        var responseCode = await projectRepository.cancleVolunteer(api: cancleVolunteer,token: token,id: event.projectId);
        emit(CancleVolunteerRequestApiLoaded(responseCode));
      } catch(e){
        emit(VolunteerPageErroe(e.toString()));
      }

    });

    on<VolunteerPageSuccessEvent>((event, emit) {
      var project = globaleState.get("volunteerProject");
      emit(VolunteerPageSuccessLoaded(project));
    });



  }
}
