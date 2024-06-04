
import 'dart:convert';
import 'dart:math';

import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/LatLng.dart';
import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/donatione.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/models/user.dart';
import 'package:alaqsa/models/user_profile.dart';
import 'package:alaqsa/models/volunteer.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/standalone.dart' as tz;
import 'package:intl/intl.dart';

class UserProfileRepository {

  GlobalState globalState = GlobalState.instance;
  getUserProfile({api,token}) async{
    User user;
    List<Volunteer> myVolunteersList = <Volunteer>[];
    List<Donatione> myDonationesList = <Donatione>[];
    List<Trip> myTripsList = <Trip>[];
    try {

      LatLng latLng;
      if(globalState.get("latlng") != null) {
        latLng = globalState.get("latlng");
      } else {
        latLng = LatLng(180, -180);
      }

      var response = await http.get(Uri.parse(api+"?lang=${latLng.lat}&long=${latLng.lng}"),headers: {"Authorization":"Bearer "+token.toString(),"Accept":"application/json"});
      if(response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var data = jsonResponse["user"];

        List myDonationesJson = data["donations"];
        List myVolunteerJson = data["volunteer"];
        List myTripJson = data["custom_trip_booking"];

        var donationCount = int.parse(data["donations_count"].toString());
        var volunteerCount = int.parse(data["volunteer_count"].toString());
        var tripCount = int.parse(data["trip_booking_count"].toString());
        var length = 0 ;

        if(donationCount >= volunteerCount) {
           length = donationCount ;
          if(length <= tripCount) {
            length = tripCount;
          }
        } else {
           length = volunteerCount ;
          if(length <= tripCount) {
            length = tripCount;
          }
        }






        if(length > 0) {
          for(var i=0;i<length;i++){

            if(myDonationesJson.isNotEmpty && myDonationesJson.length > i){
              Donatione donatione = Donatione.fromJson(myDonationesJson[i]);
              myDonationesList.add(donatione);
            }

            if(myVolunteerJson.isNotEmpty && myVolunteerJson.length > i){

              Volunteer volunteer = Volunteer.fromJson(myVolunteerJson[i]);
              myVolunteersList.add(volunteer);
            }

            if(myTripJson.isNotEmpty && myTripJson.length > i){
              Trip trip = Trip.fromJson(myTripJson[i]["project"]);
              myTripsList.add(trip);
            }
          }


        }

        user = User.fromJson(data);
        UserProfile userProfile = UserProfile(user, myDonationesList, myVolunteersList, myTripsList, donationCount, tripCount, volunteerCount);

        return userProfile;
      } else {
        return null;
      }
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

}