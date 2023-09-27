import 'package:alaqsa/bloc/user_profile/user_profile_state.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/user_profile.dart';
import 'package:alaqsa/repository/auth_repository.dart';
import 'package:alaqsa/repository/user_profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_profile_event.dart';


class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {


  UserProfileBloc() : super(UserProfileInitial()) {
    UserProfileRepository userProfileRepository = UserProfileRepository();
    AuthRepository authRepository = AuthRepository();
    var api = Config.BaseUrl+Config.InformationUserAPI;
    var removeAccountApi = Config.BaseUrl+Config.RemoveAccountAPI;

    on<UserProfileApiEvent>((event, emit) async{
      try{
        emit(UserProfileInitial());
        final prefs = await SharedPreferences.getInstance();
        var token = prefs.getString("token");
        var userProfile = await userProfileRepository.getUserProfile(api: api,token: token);

        if(userProfile != null) {
          emit(UserProfileLoaded(userProfile));
        } else {
          emit(UserProfileError("error"));
        }

      } catch(e){
        print(e.toString());
        emit(UserProfileError(e.toString()));
      }

    });

    on<RemoveAccountUserEvent>((event, emit) async{

      emit(UserProfileInitial());
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var removeAccount = await authRepository.removeAccount(api: removeAccountApi,token: token);
      if(removeAccount != null) {
        emit(RemoveAccountUserLoaded(removeAccount));
      } else {
        emit(UserProfileError("error"));
      }
    });

  }
}
