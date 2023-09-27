import 'package:alaqsa/bloc/main_page/main_page_state.dart';
import 'package:alaqsa/bloc/settings/settings_state.dart';
import 'package:alaqsa/bloc/user_profile/user_profile_state.dart';
import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/user.dart';
import 'package:alaqsa/models/user_profile.dart';
import 'package:alaqsa/repository/main_page_repository.dart';
import 'package:alaqsa/repository/settings_repository.dart';
import 'package:alaqsa/repository/user_profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_event.dart';


class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {



  SettingsBloc() : super(SettingsInitial()) {
    SettingsRepository settingsRepository = SettingsRepository();
    var contactUsApi = Config.BaseUrl+Config.ContactUsAPI;
    var aboutUsApi = Config.BaseUrl+Config.AboutUsAPI;
    var sendReportProblemAPI = Config.BaseUrl+Config.SendReportProblemAPI;

    on<ContactUsEvent>((event, emit) async{
      try{
       emit(SettingsInitial());
       var contactUs = await settingsRepository.getInformationContactUs(api: contactUsApi);
       if(contactUs != null) {
         emit(ContactUSLoaded(contactUs));
       } else {
         emit(SettingsError("error"));
       }

      } catch(e){
        print(e.toString());
        emit(SettingsError(e.toString()));
      }

    });

    on<AboutUsEvent>((event, emit) async{
      try{
        emit(SettingsInitial());
        var aboutUs = await settingsRepository.getInformationAboutUs(api: aboutUsApi);
        if(aboutUs != null) {
          emit(AboutUSLoaded(aboutUs));
        } else {
          emit(SettingsError("error"));
        }
      } catch(e){
        print(e.toString());
        emit(SettingsError(e.toString()));
      }

    });

    on<ReportProblemEvent>((event, emit) async{
      try{

        GlobalState globalState = GlobalState.instance;
        if(globalState.get("user") != null) {
          User user = globalState.get("user");
          emit(ReportProblemLoaded(user));
        } else {
          emit(SettingsError("error"));
        }

      } catch(e){
        print(e.toString());
        emit(SettingsError(e.toString()));
      }

    });

    on<ReportProblemOnClickEvent>((event, emit) async{
      try{
        emit(SettingsInitial());
        var isSuccess = await settingsRepository.sendReportProblem(api: sendReportProblemAPI,name: event.name,numberPhone: event.phoneNumber,textProblem: event.messageOnProblem);
         if(isSuccess != null) {
           emit(ReportProblemSendLoaded(isSuccess));
         } else {
           emit(SettingsSendReportError("error"));
         }


      } catch(e){
        print(e.toString());
        emit(SettingsSendReportError(e.toString()));
      }

    });

    on<GlobalSettingOnClickEvent>((event, emit) async{
      try{

        emit(SettingsInitial());
        final prefs = await SharedPreferences.getInstance();
        var activeNotification = prefs.getBool("activeNotification");
        var activeSms = prefs.getBool("activeSms");
        if(activeNotification != event.avtiveNotfiaction){
          prefs.setBool("activeNotification",event.avtiveNotfiaction);
        }
        if(activeSms != event.avtiveSms){
          prefs.setBool("activeSms",event.avtiveSms);
        }

        emit(GlobalSettingLoaded(event.avtiveNotfiaction, event.avtiveSms));

      } catch(e){
        print(e.toString());
        emit(SettingsError(e.toString()));
      }

    });

    on<GlobalSettingEvent>((event, emit) async{
      try{
        emit(SettingsInitial());
        final prefs = await SharedPreferences.getInstance();
        var activeNotification = prefs.getBool("activeNotification");
        var activeSms = prefs.getBool("activeSms");
        emit(GlobalSettingLoaded(activeNotification, activeSms));

      } catch(e){
        print(e.toString());
        emit(SettingsError(e.toString()));
      }

    });
  }
}
