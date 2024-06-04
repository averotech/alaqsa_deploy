// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
//
// import '../../helper/config.dart';
// import '../../repository/auth_repository.dart';
// import 'reset_password_event.dart';
// import 'reset_password_state.dart';
//
// class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
//   final AuthRepository authRepository;
//
//   ResetPasswordBloc(this.authRepository) : super(ResetPasswordInitial());
//
//   @override
//   Stream<ResetPasswordState> mapEventToState(ResetPasswordEvent event) async* {
//     if (event is ResetPasswordApiEvent) {
//       yield ResetPasswordLoading();
//       try {
//         var api = Config.BaseUrl + Config.ResetPasswordApi;
//         var response = await authRepository.resetPassword(email: event.email, api: api);
//         print('xxx $response');
//         yield ResetPasswordSuccess();
//       } catch (error) {
//         yield ResetPasswordError(error.toString());
//       }
//     }
//   }
// }


import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'reset_password_event.dart';
import 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordInitial());


  @override
  Stream<ResetPasswordState> mapEventToState(ResetPasswordEvent event) async* {
    if (event is ResetPasswordApiEvent) {
      yield* _mapResetPasswordApiEventToState(event);
    }
  }

  Stream<ResetPasswordState> _mapResetPasswordApiEventToState(
      ResetPasswordApiEvent event,
      ) async* {
    yield ResetPasswordLoading();
    try {
      final response = await http.post(
        Uri.parse('https://aqsana.org/api/reset_password_request'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': event.email}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        yield ResetPasswordSuccess();
      } else {
        yield ResetPasswordFailure(
            'Password reset failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      yield ResetPasswordFailure('An error occurred: $error');
    }
  }
}
