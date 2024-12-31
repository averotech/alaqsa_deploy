// location_service.dart

import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alaqsa/helper/config.dart';

import '../helper/GlobalState.dart';
import '../models/LatLng.dart';

class LocationService {
  // Method to get the current location
  static Future<Position?> getLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await _showSnackbar(context, "Location services are required for this feature. Please enable them in your device's settings.");
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await _showSnackbar(context, "Location access is required for this feature. Please enable it in your device's settings");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await _showSnackbar(context, "Location access is permanently denied. Please enable it in your device's settings");
      return null;
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
  }

  // Show Snackbar message
  static Future<void> _showSnackbar(BuildContext context, String message) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message, textAlign: TextAlign.center)));
  }

  // Method to initiate the location check
  static Future<void> initiateLocationCheck(BuildContext context) async {
    try {
      var currentLocation = await getLocation(context);
      if (currentLocation == null) {
        // Location is not available, provide fallback Position
        GlobalState globalState = GlobalState.instance;
        globalState.clear();

        // Assign default values when location is not available
        currentLocation = Position(
          latitude: 32.130492742251334, // Default latitude
          longitude: 34.97348856681219, // Default longitude
          timestamp: DateTime.now(),
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
          altitudeAccuracy: 0.0, // Default value for altitudeAccuracy
          headingAccuracy: 0.0, // Default value for headingAccuracy
        );

        var myAddress = 'אלנור 16, Kafr Bara, Israel'; // Default address
        globalState.set("myAddress", myAddress);
        globalState.set("currentLocation", currentLocation);
        LatLng latLng = LatLng(currentLocation.latitude, currentLocation.longitude);
      } else {
        final prefs = await SharedPreferences.getInstance();
        var token = prefs.getString("token") ?? "";
        LatLng latLng = LatLng(currentLocation.latitude, currentLocation.longitude);
        var myAddress = await Config.getInformastionLocation(latLng: latLng);

        GlobalState globalState = GlobalState.instance;
        globalState.set("currentLocation", currentLocation);
        globalState.set("latlng", latLng);
        globalState.set("myAddress", myAddress);
      }
    } catch (e) {
      GlobalState globalState = GlobalState.instance;
      globalState.clear();
      _handleMissingLocationData();
    }
  }

  // Handle missing location data
  static void _handleMissingLocationData() {
    print("Location data is missing. Proceeding with default settings.");
  }
}
