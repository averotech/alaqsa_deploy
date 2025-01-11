import 'dart:async';

import 'package:alaqsa/bloc/donation_page/donation_page_event.dart';
import 'package:alaqsa/bloc/donation_page/donation_page_state.dart';
import 'package:alaqsa/bloc/home_page/home_page_state.dart';
import 'package:alaqsa/bloc/news/news_event.dart';
import 'package:alaqsa/bloc/news/news_state.dart';
import 'package:alaqsa/bloc/project/project_event.dart';
import 'package:alaqsa/bloc/project/project_state.dart';
import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/MYLoaction.dart';
import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/bus.dart';
import 'package:alaqsa/models/donatione.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/repository/donation_repository.dart';
import 'package:alaqsa/repository/main_page_repository.dart';
import 'package:alaqsa/repository/news_repository.dart';
import 'package:alaqsa/repository/paypal_repository.dart';
import 'package:alaqsa/repository/project_repository.dart';
import 'package:alaqsa/repository/trips_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/standalone.dart';


class DonationPageBloc extends Bloc<DonationPageEvent, DonationPageState> {
  GlobalState globaleState = GlobalState.instance;
  DonationRepository donationRepository = DonationRepository();
  PaypalRepository paypalRepository = PaypalRepository();
  var api = Config.BaseUrl+Config.DonationAPI;
  var cancleBookingApi = Config.BaseUrl+Config.CancleBookingTripAPI;

  DonationPageBloc() : super(DonationPageInitial()) {
    on<DonationPageInitialEvent>((event, emit) async{
      var trip = globaleState.get("donationTrip");
      var project = globaleState.get("donationProject");
      var user = globaleState.get("user");
      var apkSettings = globaleState.get("apkSettings");
      if(project != null){
        emit(DonationPageLoaded.Project(project,user,apkSettings));
      }
      if(trip != null) {
        emit(DonationPageLoaded.Trip(trip,user,apkSettings));
      }

    });


    on<DonationPageRequestApiEvent>((event, emit) async{
      try {
        emit(DonationPageInitial());
        final prefs = await SharedPreferences.getInstance();
        var token = prefs.getString("token");
        var responseCode = await donationRepository.donation(api: api,token: token,id: event.projectId,projectType: event.projectType,numberPerson: event.numberOfPeople,amount: event.amount,donorName: event.donorName);
        emit(DonationRequestApiLoaded(responseCode));
      } catch(e){
        emit(DonationPageErroe(e.toString()));
      }

    });

    on<DonationPageTextEditionTotalAmountEvent>((event, emit) {
      emit(DonationChangePrice(event.totalAmount));
    });


    on<PaypalPaymentEvent>((event,emit) async{

        try {
          emit(DonationPageInitial());
          String returnURL = 'return.example.com';
          String cancelURL= 'cancel.example.com';
          var accessToken = await paypalRepository.getAccessToken();
          final transactions = paypalRepository.getParams(return_url:returnURL,cancel_url:cancelURL,projectName: event.nameProject,price: event.totalPrice,quantity: event.numberOfPeople == ""?"1":event.numberOfPeople);
          final res = await paypalRepository.createPaypalPayment(transactions, accessToken);
          var checkoutUrl = "";
          if (res != null) {

            checkoutUrl = res["approvalUrl"]!;
            var executeUrl = res["executeUrl"]!;
             emit(PaypalPaymentState(checkoutUrl,returnURL,cancelURL));

          }

        } catch (e) {
          print('exception: '+e.toString());
          emit(DonationPageErroe(e.toString()));
          // _scaffoldKey.currentState?.showSnackBar(snackBar);
        }
    });



  }
}
