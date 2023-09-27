

import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:equatable/equatable.dart';

abstract class VolunteerPageEvent extends Equatable{

  const VolunteerPageEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class VolunteerPageInitialEvent extends VolunteerPageEvent {

  VolunteerPageInitialEvent();

}



class VolunteerPageRequestApiEvent extends VolunteerPageEvent {

  var projectId;

  VolunteerPageRequestApiEvent(this.projectId);


  @override
  // TODO: implement props
  List<Object?> get props => [projectId];
}


class CancleVolunteerPageRequestApiEvent extends VolunteerPageEvent {
  var projectId;
  CancleVolunteerPageRequestApiEvent(this.projectId);

  @override
  // TODO: implement props
  List<Object?> get props => [projectId];
}


class VolunteerPageSuccessEvent extends VolunteerPageEvent {

  VolunteerPageSuccessEvent();

}




