

import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable{

  const RegisterEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegisterInitialEvent extends RegisterEvent {
  RegisterInitialEvent();
}

class RegisterApiEvent extends RegisterEvent {
  var _name;
  var _email;
  var _phone_number;
  var _password;
  var _cities;
  RegisterApiEvent(this._name,this._email,this._phone_number,this._password, this._cities);

  get name => _name;
  get password => _password;
  get email => _email;
  get phone_number=>_phone_number;
  get cities=>_cities;


  @override
  // TODO: implement props
  List<Object?> get props => [name,email,password,phone_number, cities];

}


class RegisterFetchCitiesEvent extends RegisterEvent {}


