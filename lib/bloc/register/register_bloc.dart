import 'dart:async';
import 'package:alaqsa/bloc/login/login_state.dart';
import 'package:alaqsa/bloc/register/register_state.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/user.dart';
import 'package:alaqsa/repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register_event.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {


  RegisterBloc() : super(RegisterInitial()) {
    AuthRepository authRepository = AuthRepository();
    var api = Config.BaseUrl+Config.RegisterAPI;
    on<RegisterApiEvent>((event, emit) async{
      try{
        emit(RegisterInitial());
        var dataAuthRepository = await authRepository.register(api: api,name: event.name,email: event.email,phone_number:event.phone_number,password: event.password,password_confirmation: event.password,cities:event.cities);
        if(dataAuthRepository[0] != null) {
          User user = dataAuthRepository[0];
          var token = dataAuthRepository[1];
          final prefs = await SharedPreferences.getInstance();
          prefs.setString("token", token);
          emit(RegisterLoaded(user,token));
        } else {
          var errorMessage = dataAuthRepository[2];
          emit(RegisterErroe(errorMessage));
        }

      } catch(e){
        print(e.toString());
        emit(RegisterErroe(e.toString()));
      }

    });
    on<RegisterFetchCitiesEvent>((event, emit) async {
      try {
        var cities = await authRepository.fetchCities();
        emit(CitiesLoaded(cities));
      } catch (e) {
        print(e.toString());
        emit(RegisterErroe(e.toString()));
      }
    });
  }
}
