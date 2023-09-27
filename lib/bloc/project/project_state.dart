import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/models/project.dart';
import 'package:equatable/equatable.dart';


abstract class ProjectState extends Equatable{
  const ProjectState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProjectInitial extends ProjectState {
  @override
  var isRefresh;
  ProjectInitial(this.isRefresh);
  // TODO: implement props
  List<Object?> get props => [isRefresh];
}


class ProjectLoaded extends ProjectState {
  final List<Project> projectsList;
  var isRefresh;
  ProjectLoaded(this.projectsList,this.isRefresh);

  @override
  // TODO: implement props
  List<Object?> get props => [projectsList,isRefresh];
}


class ProjectFoundNextPages extends ProjectState {
  final nextPageUrl;
  ProjectFoundNextPages(this.nextPageUrl);

  @override
  // TODO: implement props
  List<Object?> get props => [nextPageUrl];
}


class DetailProjectState extends ProjectState{
  Project project;
  DetailProjectState(this.project);

  @override
  // TODO: implement props
  List<Object?> get props => [project];
}
class UpdateProject extends ProjectState {
  Project project;
  UpdateProject(this.project);

  @override
  // TODO: implement props
  List<Object?> get props => [project];
}


class ProjectErroe extends ProjectState {
  final error;
  ProjectErroe(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}


