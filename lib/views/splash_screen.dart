import 'dart:async';

import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/LatLng.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }

}
class SplashScreenState extends State<SplashScreen>{
  GlobalState globalState = GlobalState.instance;
  @override
  void initState() {
   Timer(Duration(seconds: 1),() async{

     final prefs = await SharedPreferences.getInstance();
     var token = prefs.getString("token");

     var correntlocation = await Config.getLoction();
     LatLng latLng = LatLng(correntlocation.latitude, correntlocation.longitude);
     var myAddress = await Config.getInformastionLocation(latLng: latLng);

     globalState.set("latlng", latLng);
     globalState.set("myAddress", myAddress);
     if(token != null && token != ""){
       Navigator.of(context).pushNamedAndRemoveUntil("MainPage", (route) => false);
     } else {
       Navigator.of(context).pushNamedAndRemoveUntil("LoginPage", (route) => false);
     }

   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.asset("assets/images/backgound.png",fit: BoxFit.cover,),
              )
          ),
          Container(
            child: Center(
              child: Image.asset("assets/images/iconApp.png"),
            ),
          )
        ],
      ),
    );
  }


}