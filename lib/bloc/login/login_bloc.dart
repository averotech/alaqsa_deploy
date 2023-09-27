import 'dart:async';

import 'package:alaqsa/bloc/home_page/home_page_state.dart';
import 'package:alaqsa/bloc/login/login_state.dart';
import 'package:alaqsa/bloc/news/news_event.dart';
import 'package:alaqsa/bloc/news/news_state.dart';
import 'package:alaqsa/bloc/project/project_event.dart';
import 'package:alaqsa/bloc/project/project_state.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/MYLoaction.dart';
import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/models/user.dart';
import 'package:alaqsa/repository/auth_repository.dart';
import 'package:alaqsa/repository/news_repository.dart';
import 'package:alaqsa/repository/project_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/standalone.dart';

import 'login_event.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {


  LoginBloc() : super(LoginInitial()) {
    AuthRepository authRepository = AuthRepository();
    var api = Config.BaseUrl+Config.LoginAPI;
    var registerLoginSocialAPI = Config.BaseUrl+Config.RegisterLoginSocialAPI;
    on<LoginApiEvent>((event, emit) async{

      try{
        emit(LoginInitial());
        var dataAuthRepository = await authRepository.login(api: api,email: event.email,password: event.password);
        if(dataAuthRepository[0] != null) {
          User user = dataAuthRepository[0];
          var token = dataAuthRepository[1];
          final prefs = await SharedPreferences.getInstance();
          prefs.setString("token", token);
          emit(LoginLoaded(user,token));
        } else {
          emit(LoginErroe("error"));
        }

      } catch(e){
        print(e.toString());

        emit(LoginErroe(e.toString()));
      }

    });

    on<LoginGoogleEvent>((event, emit) async{

      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );
      try {
        var isSignin = await _googleSignIn.signIn();

        if(isSignin != null) {
          emit(LoginInitial());
          var dataAuthRepository = await authRepository.registerLoginSocail(api: registerLoginSocialAPI,email: isSignin?.email.toString(),name: isSignin?.displayName.toString(),socialMediaId: isSignin?.id.toString());
          if(dataAuthRepository[0] != null) {
            User user = dataAuthRepository[0];
            var token = dataAuthRepository[1];
            final prefs = await SharedPreferences.getInstance();
            prefs.setString("token", token);
            emit(LoginLoaded(user,token));
          } else {
            emit(LoginErroe("error"));
          }
        }


      } catch (error) {
        emit(LoginErroe("error"));
      }

    });

    on<LoginFacebookEvent>((event, emit) async{
      try{
        final LoginResult result = await FacebookAuth.instance.login(
          permissions: ['public_profile', 'email'],
        );

        if (result.status == LoginStatus.success) {
          final userData = await FacebookAuth.instance.getUserData();
          emit(LoginInitial());
          var dataAuthRepository = await authRepository.registerLoginSocail(api: registerLoginSocialAPI,email: userData["email"].toString(),name: userData["name"].toString(),socialMediaId: userData["id"]);
          if(dataAuthRepository[0] != null) {
            User user = dataAuthRepository[0];
            var token = dataAuthRepository[1];
            final prefs = await SharedPreferences.getInstance();
            prefs.setString("token", token);
            emit(LoginLoaded(user,token));
          } else {
            emit(LoginErroe("error"));
          }


        } else {
          print(result.status);
          print(result.message);
        }
      } catch(e){
        print(e);
      }


    });
  }

  // logOutGoogle() async {
  //   await _googleSignIn.signOut();
  // }

  // logOutFC() async {
  //   await FacebookAuth.instance.logOut();
  // }
}
