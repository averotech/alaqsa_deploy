// import 'package:equatable/equatable.dart';
//
// abstract class ResetPasswordState extends Equatable {
//   const ResetPasswordState();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class ResetPasswordInitial extends ResetPasswordState {
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }
//
// class ResetPasswordLoading extends ResetPasswordState {
//
// }
//
// class ResetPasswordSuccess extends ResetPasswordState {}
//
// class ResetPasswordError extends ResetPasswordState {
//   final error;
//   ResetPasswordError(this.error);
//   @override
//   // TODO: implement props
//   List<Object?> get props => [error];
// }
import 'package:equatable/equatable.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {}

class ResetPasswordFailure extends ResetPasswordState {
  final String error;

  const ResetPasswordFailure(this.error);

  @override
  List<Object> get props => [error];
}


