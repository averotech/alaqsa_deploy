import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/models/user.dart';
import 'package:alaqsa/models/user_profile.dart';
import 'package:equatable/equatable.dart';


abstract class UserProfileState extends Equatable{
  const UserProfileState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserProfileInitial extends UserProfileState {

  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class UserProfileLoaded extends UserProfileState {
  UserProfile userProfile;
  UserProfileLoaded(this.userProfile);

  @override
  // TODO: implement props
  List<Object?> get props => [userProfile];
}


class RemoveAccountUserLoaded extends UserProfileState {
  var isRemoved;
  RemoveAccountUserLoaded(this.isRemoved);

  @override
  // TODO: implement props
  List<Object?> get props => [isRemoved];
}



class UserProfileError extends UserProfileState {
  final error;
  UserProfileError(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}


