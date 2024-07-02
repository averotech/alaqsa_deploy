import 'dart:convert';

import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/LatLng.dart';
import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/news.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/standalone.dart' as tz;
import 'package:intl/intl.dart';

class TripsRepository {
  GlobalState globalState = GlobalState.instance;

  getTrips(api, skip, token) async {
    List<Trip> tripsList = <Trip>[];
    try {
      LatLng latLng;
      if (globalState.get("latlng") != null) {
        latLng = globalState.get("latlng");
      } else {
        latLng = LatLng(180, -180);
      }
      var response;
      if (token != "" && token.toString() != "null") {
        response = await http.get(
            Uri.parse(
                api + "?skip=${skip}&lat=${latLng.lat}&lng=${latLng.lng}"),
            headers: {"Authorization": "Bearer " + token.toString()});
      } else {
        response = await http.get(Uri.parse(
            api + "?skip=${skip}&lat=${latLng.lat}&lng=${latLng.lng}"));
      }
      
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        var data = jsonResponse["data"];

        if (data.isNotEmpty) {
          for (var i = 0; i < data.length; i++) {
            Trip trip = Trip.fromJson(data[i]);
            tripsList.add(trip);
          }
          return tripsList;
        } else {
          return tripsList;
        }
      } else {
        return tripsList;
      }
    } catch (e) {
      print(e.toString());
      return tripsList;
    }
  }

  searchTrips(api, search, token) async {
    List<Trip> tripsList = <Trip>[];
    try {
      LatLng latLng;
      if (globalState.get("latlng") != null) {
        latLng = globalState.get("latlng");
      } else {
        latLng = LatLng(180, -180);
      }
      var response;
      if (token != "" && token.toString() != "null") {
        response = await http.get(
            Uri.parse(
                api + "?search=${search}&lat=${latLng.lat}&lng=${latLng.lng}"),
            headers: {"Authorization": "Bearer " + token.toString()});
      } else {
        response = await http.get(Uri.parse(
            api + "?search=${search}&lat=${latLng.lat}&lng=${latLng.lng}"));
      }
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        var data = jsonResponse["data"];
        if (data.isNotEmpty) {
          for (var i = 0; i < data.length; i++) {
            Trip trip = Trip.fromJson(data[i]);
            tripsList.add(trip);
          }
          return tripsList;
        } else {
          return tripsList;
        }
      } else {
        return tripsList;
      }
    } catch (e) {
      print(e.toString());
      return tripsList;
    }
  }

  bookingTrips({api, token, tripId, busId, numberPerson, numberPhone}) async {
    try {
      var busID = busId.toString() != "null" ? busId.toString() : "";
      var response = await http.post(Uri.parse(api), body: {
        'project_id': tripId.toString(),
        'bus_id': busID.toString(),
        'number_of_people': numberPerson.toString(),
        'number_phone': numberPhone.toString()
      }, headers: {
        "Authorization": "Bearer " + token.toString()
      });

      print(response.statusCode);
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {'statusCode': 200, 'data': responseBody};
      } else {
        return {'statusCode': response.statusCode, 'data': responseBody};
      }
    } catch (e) {
      print(e.toString());
      return {'statusCode': 500, 'message': e.toString()};
    }
  }


  cancleBookingTrips({api, token, tripId}) async {
    try {
      var response = await http.post(Uri.parse(api), body: {
        'id': tripId.toString(),
      }, headers: {
        "Authorization": "Bearer " + token.toString()
      });

      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      print(e.toString());
      return 500;
    }
  }
}
