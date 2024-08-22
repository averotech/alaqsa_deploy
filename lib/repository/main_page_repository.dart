
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

class MainPageRepository {

  GlobalState globalState = GlobalState.instance;
  getUser({api,token}) async{
    User user;
    try {
      var response = await http.get(Uri.parse(api),headers: {"Authorization":"Bearer "+token.toString(),"Accept":"application/json"});
      if(response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var data = jsonResponse;
        user = User.fromJson(data);
        globalState.set("user", user);
        return user;
      } else {
        return null;
      }
    } catch(e) {
      print(e.toString());
      return null;
    }
  }


  getNearTripAndBokkingTrip({api,token}) async{
    var response;
    try {
      LatLng? latLng = globalState.get("latlng") as LatLng?;
      latLng ??= LatLng(32.130492742251334, 34.97348856681219);
      if(token.toString() != "" && token.toString() != "null"){

        response = await http.get(Uri.parse(api+"?lat=${latLng.lat}&lng=${latLng.lng}"),headers: {"Authorization":"Bearer "+token.toString(),"Accept":"application/json"});
      } else {
        response = await http.get(Uri.parse(api+"?lat=${latLng.lat}&lng=${latLng.lng}"));
      }

      if(response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print('xxxxx${token.toString()} lat:${latLng.lat},,,,, lan:${latLng.lng}, apii:${Uri.parse(api+"?lat=${latLng.lat}&lng=${latLng.lng}")}');
        var data = jsonResponse["data"];

        Trip trip = Trip.fromJson(data);
        return trip;
      } else {
        return null;
      }
    } catch(e) {
      print(e.toString());
      return null;
    }
  }



  getInformationSocialMedia({api}) async{
    User user;
    try {
      var response = await http.get(Uri.parse(api));

      if(response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var data = jsonResponse["data"];
        var socialMedia = [];
        socialMedia.add(data["instagram"]);
        socialMedia.add(data["twitter"]);
        socialMedia.add(data["facebook"]);

        return socialMedia;
      } else {
        return [];
      }
    } catch(e) {
      print(e.toString());
      return [];
    }
  }


  autoCompleteSearch({api,search}) async{
    try {
      var response = await http.get(Uri.parse(api+"?search=${search}"),headers: {"Accept":"application/json"});

      if(response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var data = jsonResponse["data"];
        if(data.isNotEmpty){
          return data;
        } else {
          return [];
        }

      } else {
        return [];
      }
    } catch(e) {
      print(e.toString());
      return [];
    }
  }

}