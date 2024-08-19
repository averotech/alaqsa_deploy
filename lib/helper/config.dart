
import 'package:alaqsa/models/LatLng.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Config {
  static var BaseUrl = "https://aqsana.org";
  static var LoginAPI = "/api/login";
  static var RegisterLoginSocialAPI = "/api/register_login_social_media";
  static var RegisterAPI = "/api/register";
  static var ResetPasswordApi = "api/reset_password_request";
  static var InformationUserAPI = "/api/getInformationUser";
  static var UserAPI = "/api/user";
  static var SocialMediaAPI = "/api/social_media";
  static var CM_FIREBASE_TOKENAPI = "/api/cm-firebase-token";
  static var RemoveAccountAPI = "/api/delete";
  static var NewsAPI = "/api/News";
  static var NearTripAPI = "/api/getNearAndBokkingTrip";
  static var TripsAPI = "/api/trips";
  static var SearchTripAPI = "/api/search_trip";
  static var SearchTripAuthAPI = "/api/search_trip-auth";
  static var AutoCompleteSearchTripAPI = "/api/auto_compleate_search_trip";
  static var NearTripAuthAPI = "/api/getNearAndBokkingTrip-auth";
  static var TripsAuthAPI = "/api/trips-auth";
  static var BookingTripAPI = "/api/trip_booking";
  static var CancleBookingTripAPI = "/api/cancel_trip_booking";
  static var GETALLProjectsAPI = "/api/projects";
  static var GETALLProjectsAPIAuth = "/api/projects-auth";
  static var ContactUsAPI = "/api/contact_us";
  static var AboutUsAPI = "/api/about_us";
  static var SendReportProblemAPI = "/api/report_problem";
  static var DonationAPI = "/api/donations-app";
  static var VoluntterAPI = "/api/volunteer_project";
  static var CancleVoluntterAPI = "/api/cancel_volunteering";
  static var UpdateUser= "/user/update";
  static var getCities="/api/get-cities";

  // static const Map<int, String> weekdayName = {1: "السبت", 2: "الأحد", 3: "الأثنين", 4: "الثلاثاء", 5: "الأربعاء", 6: "الخميس", 7: "الجمعة"};
  static const Map<int, String> weekdayName = {
    1: "الأثنين",
    2: "الثلاثاء",
    3: "الأربعاء",
    4: "الخميس",
    5: "الجمعة",
    6: "السبت",
    7: "الأحد"
  };
  //Check Show Loading Dialog
 static var isShowingLoadingDialog = false;


 static launchURL({uri}) async{
   if (!await launchUrl(uri)) {
   throw 'Could not launch $uri';
   }
 }
   static launchFCBURL() async{
    const url = 'https://www.facebook.com/ameedasmah'; // Replace with your Facebook page URL
    if (await canLaunchUrl(url as Uri)) {
      await launchUrl(url as Uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  static getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are disabled.");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permissions are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      print("Location permissions are permanently denied, we cannot request permissions.");
      // return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
  }



  static Future<String> getInformastionLocation({required LatLng latLng}) async{
    List<Placemark> placemarks = await placemarkFromCoordinates(latLng.lat,latLng.lng);
    Placemark placeMark  = placemarks[0];
    String? name = placeMark.name;
    String? subLocality = placeMark.subLocality;
    String? locality = placeMark.locality;
    String? administrativeArea = placeMark.administrativeArea;
    String? country = placeMark.country;
    String? address = "${name}, ${subLocality}, ${locality}, ${country}";
    return locality.toString();
  }

  static Future<bool> checkLogin() async{
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if(token != null && token != ""){
      return true;
    } else{
      return false;
    }

  }


  static Future<void> share({title,text}) async {
    await FlutterShare.share(
        title: '$title',
        text: '$text',
        linkUrl: BaseUrl,
        chooserTitle: '$title'
    );
  }



}