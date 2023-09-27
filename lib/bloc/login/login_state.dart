import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/models/user.dart';
import 'package:equatable/equatable.dart';


abstract class LoginState extends Equatable{
  const LoginState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {

  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class LoginLoaded extends LoginState {
  User user;
  var token;
  LoginLoaded(this.user,this.token);

  @override
  // TODO: implement props
  List<Object?> get props => [user,token];
}



class LoginErroe extends LoginState {
  final error;
  LoginErroe(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}


