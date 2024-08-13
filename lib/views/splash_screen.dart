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

    // Delay the start of the app initialization until after the first frame is drawn
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAppInitialization();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Remove observer
    super.dispose();
  }

  Future<void> _startAppInitialization() async {
    var currentLocation = await getLocation(context);
    if (currentLocation == null) {
      // If location is not granted, show permission denied dialog
      await _showPermissionDeniedDialog(context);
      return;
    }

    Timer(Duration(seconds: 1), () async {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");

      LatLng latLng = LatLng(currentLocation.latitude, currentLocation.longitude);
      var myAddress = await Config.getInformastionLocation(latLng: latLng);

      globalState.set("latlng", latLng);
      globalState.set("myAddress", myAddress);

      if (token != null && token.isNotEmpty) {
        Navigator.of(context).pushNamedAndRemoveUntil("MainPage", (route) => false);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil("LoginPage", (route) => false);
      }
    });
  }

  Future<void> _showPrePermissionDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("تحديد الموقع مطلوب"),
          content: Text("يحتاج هذا التطبيق إلى الوصول إلى موقعك لتقديم كافة الخدمات والعمل بشكل صحيح."),
          actions: <Widget>[
            TextButton(
              child: Text("موافق"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showPermissionDeniedDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("تم رفض الوصول إلى الموقع"),
          content: Text("للاستفادة من هذه الميزة بشكل صحيح، يجب تمكين الوصول إلى الموقع في إعدادات جهازك. بدون ذلك، قد لا تتمكن من رؤية الرحلات القريبة منك بدقة. يرجى تفعيل الموقع لضمان عمل التطبيق بشكل صحيح."),
          actions: <Widget>[
            TextButton(
              child: Text("اذهب إلى الإعدادات"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Geolocator.openAppSettings(); // Open app settings
              },
            ),
            TextButton(
              child: Text("إلغاء"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Navigate to a different screen
                Navigator.of(context).pushNamedAndRemoveUntil("LoginPage", (route) => false);
                // You can replace "HomePage" with the name of the screen you want to show after cancellation.
              },
            ),
          ],
        );
      },
    );
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
      await _showSnackbarAndHandlePermissionDenied(context, "مطلوب الوصول إلى الموقع لاستخدام هذا التطبيق. يرجى تمكين خدمات الموقع في إعدادات جهازك.");
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await _showSnackbarAndHandlePermissionDenied(context, "مطلوب الوصول إلى الموقع لاستخدام هذا التطبيق. يرجى تمكين خدمات الموقع في إعدادات جهازك.");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await _showSnackbarAndHandlePermissionDenied(context, "تم رفض الوصول إلى الموقع بشكل دائم. يرجى تمكين خدمات الموقع في إعدادات جهازك.");
      return null;
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
  }

  static Future<void> _showSnackbarAndHandlePermissionDenied(BuildContext context, String message) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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
