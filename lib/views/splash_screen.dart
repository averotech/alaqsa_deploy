import 'dart:async';
import 'package:alaqsa/helper/GlobalState.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'location_service.dart';

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
    // Check if the app is outdated
    if (await _isAppOutdated()) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        "UpdateVersionPage",
            (route) => false,
        arguments: {
          'latestVersion': '1.0.6',
          'updateLink': 'https://www.google.com',
        },
      );
      return; // Prevent further navigation
    }
    // Pass the current BuildContext to the location service method
    await LocationService.initiateLocationCheck(context); // Now passing context

    // After the location check completes, check the token for login state
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    if (token != null && token.isNotEmpty) {
      // If token exists and is valid, navigate to MainPage
      Navigator.of(context).pushNamedAndRemoveUntil("MainPage", (route) => false);
    } else {
      // Otherwise, navigate to LoginPage
      Navigator.of(context).pushNamedAndRemoveUntil("LoginPage", (route) => false);
    }
  }
  Future<bool> _isAppOutdated() async {
    // Replace with your API call or logic to fetch the latest version
    const latestVersion = "1.0.6"; // Example latest version
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;
    return currentVersion != latestVersion; // Check if versions mismatch
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
