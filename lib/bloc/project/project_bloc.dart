import 'dart:async';

import 'package:alaqsa/bloc/news/news_event.dart';
import 'package:alaqsa/bloc/news/news_state.dart';
import 'package:alaqsa/bloc/project/project_event.dart';
import 'package:alaqsa/bloc/project/project_state.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/repository/news_repository.dart';
import 'package:alaqsa/repository/project_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {

  ProjectBloc() : super(ProjectInitial(false)) {
    ProjectRepository projectRepository = ProjectRepository();
    var api = Config.BaseUrl+Config.GETALLProjectsAPI;
    var apiAuth = Config.BaseUrl+Config.GETALLProjectsAPIAuth;
    on<LoadProjectAPIEvent>((event, emit) async{
      emit(ProjectInitial(event.isRefresh));
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var dataProjectRepository = await projectRepository.getProjects(token.toString() != "" && token.toString() != "null"?apiAuth:api,token);
      List<Project> projectList = dataProjectRepository[0];
      var nextPageUrl = dataProjectRepository[1];
      emit(ProjectFoundNextPages(nextPageUrl));
      emit(ProjectLoaded(projectList,event.isRefresh));
    });

    on<LoadProjectAPINextPageEvent>((event, emit) async{
      emit(ProjectInitial(false));
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var dataNewsRepository = await projectRepository.getProjects(event.nextPageUrl,token);
      List<Project> projectList = event.projectList+dataNewsRepository[0];
      var nextPageUrl = dataNewsRepository[1];
      emit(ProjectFoundNextPages(nextPageUrl));
      emit(ProjectLoaded(projectList,false));
    });
    on<DetailProjectEvent>((event,emit) async{
      Project project = projectRepository.getDetailProjectNews();
      emit(DetailProjectState(project));
    });

    on<UpdateDetailProjectEvent>((event,emit) async{
      Project project = event.project;
      project.is_volunteer_user = false;
      emit(UpdateProject(project));
    });


    on<UpdateProjectEvent>((event,emit) async{
      Project project = event.project;
      project.is_volunteer_user = false;
      emit(UpdateProject(project));
    });


  }
}
