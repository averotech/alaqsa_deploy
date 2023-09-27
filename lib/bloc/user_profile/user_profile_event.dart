

import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:equatable/equatable.dart';

abstract class UserProfileEvent extends Equatable{

  const UserProfileEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserProfileInitialEvent extends UserProfileEvent {
  UserProfileInitialEvent();
}

class RemoveAccountUserEvent extends UserProfileEvent {
    RemoveAccountUserEvent();
}



class UserProfileApiEvent extends UserProfileEvent {

  UserProfileApiEvent();


  @override
  // TODO: implement props
  List<Object?> get props => [];

}

