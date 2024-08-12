import 'dart:async';
import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/LatLng.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver {
  GlobalState globalState = GlobalState.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Add observer
    _startAppInitialization();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Remove observer
    super.dispose();
  }

  void _startAppInitialization() {
    Timer(Duration(seconds: 1), () async {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");

      var currentLocation = await getLocation(context);
      if (currentLocation == null) return; // Exit if location permission is not granted

      LatLng latLng = LatLng(currentLocation.latitude, currentLocation.longitude);
      var myAddress = await Config.getInformastionLocation(latLng: latLng);

      globalState.set("latlng", latLng);
      globalState.set("myAddress", myAddress);

      if (token != null && token != "") {
        Navigator.of(context).pushNamedAndRemoveUntil("MainPage", (route) => false);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil("LoginPage", (route) => false);
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App has returned to the foreground, recheck permissions
      _startAppInitialization();
    }
  }

  static Future<Position?> getLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await _showSnackbarAndHandlePermissionDenied(context, "Location access is required to use this app. Please enable location services in your device settings to continue.");
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await _showSnackbarAndHandlePermissionDenied(context, "Location access is required to use this app. Please enable location services in your device settings to continue.");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await _showSnackbarAndHandlePermissionDenied(context, "Location access is required to use app. Please enable location services in your device settings to continue.");
      return null;
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
  }

  static Future<void> _showSnackbarAndHandlePermissionDenied(BuildContext context, String message) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );

    await Future.delayed(Duration(seconds: 2));
    Geolocator.openAppSettings();
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
              child: Image.asset(
                "assets/images/backgound.png",
                fit: BoxFit.cover,
              ),
            ),
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