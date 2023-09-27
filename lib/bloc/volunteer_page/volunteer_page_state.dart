import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/models/project.dart';
import 'package:equatable/equatable.dart';


abstract class VolunteerPageState extends Equatable{
  const VolunteerPageState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class VolunteerPageInitial extends VolunteerPageState {
  @override

  VolunteerPageInitial();
  // TODO: implement props
  List<Object?> get props => [];
}


class VolunteerPageLoaded extends VolunteerPageState {
  var project;
  var user;
  var myAddress;
  VolunteerPageLoaded(this.project,this.user,this.myAddress);

  @override
  // TODO: implement props
  List<Object?> get props => [project];
}



class VolunteerRequestApiLoaded extends VolunteerPageState {
  var responseCode;
  VolunteerRequestApiLoaded(this.responseCode);

  @override
  // TODO: implement props
  List<Object?> get props => [responseCode];
}


class CancleVolunteerRequestApiLoaded extends VolunteerPageState {
  var responseCode;
  CancleVolunteerRequestApiLoaded(this.responseCode);

  @override
  // TODO: implement props
  List<Object?> get props => [responseCode];
}


class VolunteerPageSuccessLoaded extends VolunteerPageState {
  var project;
  VolunteerPageSuccessLoaded(this.project);

  @override
  // TODO: implement props
  List<Object?> get props => [project];
}


class VolunteerPageErroe extends VolunteerPageState {
  final error;
  VolunteerPageErroe(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}




