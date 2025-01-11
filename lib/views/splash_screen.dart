import 'dart:async';
import 'dart:convert';
import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import HTTP package
import '../VersionCheckService.dart';
import 'location_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  GlobalState globalState = GlobalState.instance;
  final VersionCheckService versionCheckService = VersionCheckService();

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
    final String apiUrl = Config.BaseUrl+Config.getSettings;
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final latestVersion = data['latestVersion'];
      final updateLink=data['updateLink'];
      bool isOutdated = await versionCheckService.isAppOutdated(latestVersion);
      // Check if the app is outdated
      if (isOutdated) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          "UpdateVersionPage",
          (route) => false,
          arguments: {
            'latestVersion': latestVersion,
            'updateLink': updateLink,
            'isOutdated': isOutdated,

          },
        );
        return; // Prevent further navigation
      } } else {
        throw Exception('Failed to load version information');

    }
    // Pass the current BuildContext to the location service method
    await LocationService.initiateLocationCheck(context); // Now passing context

    // After the location check completes, check the token for login state
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    if (token != null && token.isNotEmpty) {
      // If token exists and is valid, navigate to MainPage
      Navigator.of(context)
          .pushNamedAndRemoveUntil("MainPage", (route) => false);
    } else {
      // Otherwise, navigate to LoginPage
      Navigator.of(context)
          .pushNamedAndRemoveUntil("LoginPage", (route) => false);
    }
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
