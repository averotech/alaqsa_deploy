

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
  RegisterApiEvent(this._name,this._email,this._phone_number,this._password);

  get name => _name;
  get password => _password;
  get email => _email;
  get phone_number=>_phone_number;


  @override
  // TODO: implement props
  List<Object?> get props => [name,email,password];

}

