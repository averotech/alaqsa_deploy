

import 'package:alaqsa/bloc/project/project_state.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:equatable/equatable.dart';

abstract class ProjectEvent extends Equatable{

  const ProjectEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadProjectAPIEvent extends ProjectEvent {
  var _isRefresh = false;
  LoadProjectAPIEvent(this._isRefresh);

  get isRefresh => _isRefresh;
}


class DetailProjectEvent extends ProjectEvent {

}

class UpdateDetailProjectEvent extends ProjectEvent {
  var project;
  UpdateDetailProjectEvent(this.project);
}



class UpdateProjectEvent extends ProjectEvent {
  Project project;
  UpdateProjectEvent(this.project);
}


class LoadProjectAPINextPageEvent extends ProjectEvent {
  var nextPageUrl;
  List<Project> projectList;
  LoadProjectAPINextPageEvent(this.nextPageUrl,this.projectList);

  @override
  // TODO: implement props
  List<Object?> get props => [nextPageUrl,projectList];
}

