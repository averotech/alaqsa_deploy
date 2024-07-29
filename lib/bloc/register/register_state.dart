import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/models/user.dart';
import 'package:equatable/equatable.dart';


abstract class RegisterState extends Equatable{
  const RegisterState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {

  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class RegisterLoaded extends RegisterState {
  User user;
  var token;
  RegisterLoaded(this.user,this.token);

  @override
  // TODO: implement props
  List<Object?> get props => [user,token];
}



class RegisterErroe extends RegisterState {
  final error;
  RegisterErroe(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}


class CitiesLoaded extends RegisterState {
  final List<String> cities;
  CitiesLoaded(this.cities);

  @override
  List<Object?> get props => [cities];
}

