import 'package:alaqsa/bloc/main_page/main_page_state.dart';
import 'package:alaqsa/bloc/user_profile/user_profile_state.dart';
import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/LatLng.dart';
import 'package:alaqsa/models/user_profile.dart';
import 'package:alaqsa/repository/auth_repository.dart';
import 'package:alaqsa/repository/main_page_repository.dart';
import 'package:alaqsa/repository/user_profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_page_event.dart';


class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {

  GlobalState globalState = GlobalState.instance;

  MainPageBloc() : super(MainPageInitial()) {
    MainPageRepository mainPageRepository = MainPageRepository();
    AuthRepository authRepository = AuthRepository();
    var api = Config.BaseUrl+Config.UserAPI;
    var getSocialmediaApi = Config.BaseUrl+Config.SocialMediaAPI;
    var updateCmApi = Config.BaseUrl+Config.CM_FIREBASE_TOKENAPI;
    on<MainPageInitialEvent>((event, emit) async{
      try{
        emit(MainPageInitial());
        final prefs = await SharedPreferences.getInstance();
        var token = prefs.getString("token");
        var isLogin = false;

        if(token != null && token != "") {
          isLogin = true;
          var user = await mainPageRepository.getUser(api: api,token: token);
          var socialMedia = await mainPageRepository.getInformationSocialMedia(api: getSocialmediaApi);

          if(user != null) {
            emit(MainPageLoaded(user,isLogin));

            if(socialMedia != null && socialMedia.isNotEmpty) {
              emit(MainPageSocialMediaLoaded(socialMedia));
            }

          } else {
            emit(MainPageError("error"));
          }
        } else {
          var socialMedia = await mainPageRepository.getInformationSocialMedia(api: getSocialmediaApi);
          emit(MainPageSocialMediaLoaded(socialMedia));
          emit(MainPageError.isAuthError("Not Auth",false));
        }

        
          Position correntlocation = await Config.getLocation();
          LatLng latLng = LatLng(correntlocation.latitude, correntlocation.longitude);
          var myAddress = await Config.getInformastionLocation(latLng: latLng);

          globalState.set("latlng", latLng);
          globalState.set("myAddress", myAddress);
          emit(MainPageCurrentLocationLoaded(correntlocation,myAddress));


      } catch(e){
        print(e.toString());
        emit(MainPageError(e.toString()));
      }

    });

    on<UpdateCmFirbaseEvent>((event, emit) async{
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      if(token != null && token.toString() != ""){
       await authRepository.updateCmFirebaseToken(updateCmApi, event.cmFirebaseToken,token);
      } else {
        print("owais");
      }

    });
  }
}
