

import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{

  const LoginEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginInitialEvent extends LoginEvent {
  LoginInitialEvent();
}

class LoginApiEvent extends LoginEvent {
  var _email;
  var _password;
  LoginApiEvent(this._email,this._password);
  get password => _password;
  get email => _email;

  @override
  // TODO: implement props
  List<Object?> get props => [email,password];

}


class LoginGoogleEvent extends LoginEvent {
  LoginGoogleEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];

}



class LoginFacebookEvent extends LoginEvent {
  LoginFacebookEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

