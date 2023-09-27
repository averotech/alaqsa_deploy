import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/models/user.dart';
import 'package:alaqsa/models/user_profile.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';


abstract class MainPageState extends Equatable{
  const MainPageState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MainPageInitial extends MainPageState {

  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class MainPageLoaded extends MainPageState {
  User user;
  var _isLogin;
  MainPageLoaded(this.user,this._isLogin);

  get isLogin => _isLogin;

  set isLogin(value) {
    _isLogin = value;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [user,isLogin];
}


class MainPageSocialMediaLoaded extends MainPageState {

  var socialMedia = [];

  MainPageSocialMediaLoaded(this.socialMedia);

  @override
  // TODO: implement props
  List<Object?> get props => [socialMedia];
}

class MainPageCurrentLocationLoaded extends MainPageState {

  Position position;
  var myaddress;

  MainPageCurrentLocationLoaded(this.position,this.myaddress);

  @override
  // TODO: implement props
  List<Object?> get props => [position,myaddress];
}



class MainPageError extends MainPageState {
  final error;
  var isLogin;
  MainPageError(this.error);
  MainPageError.isAuthError(this.error,this.isLogin);
  @override
  // TODO: implement props
  List<Object?> get props => [error,isLogin];
}


