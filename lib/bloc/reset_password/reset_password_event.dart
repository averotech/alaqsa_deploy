// import 'package:equatable/equatable.dart';
//
// abstract class ResetPasswordEvent extends Equatable {
//   const ResetPasswordEvent();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class ResetPasswordInitialEvent extends ResetPasswordEvent {
//   ResetPasswordInitialEvent();
// }
//
// class ResetPasswordApiEvent extends ResetPasswordEvent {
//   var _email;
//   ResetPasswordApiEvent(this._email);
//   get email => _email;
//   @override
//   List<Object?> get props => [email];
// }

import 'package:equatable/equatable.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class ResetPasswordInitialEvent extends ResetPasswordEvent {
  ResetPasswordInitialEvent();
}

class ResetPasswordApiEvent extends ResetPasswordEvent {
  var _email;
  ResetPasswordApiEvent(this._email);
  get email => _email;

  @override
  List<Object> get props => [email];
}