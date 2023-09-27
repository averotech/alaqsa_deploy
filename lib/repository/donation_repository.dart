
import 'dart:convert';

import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/LatLng.dart';
import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/news.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/standalone.dart' as tz;
import 'package:intl/intl.dart';

class DonationRepository {

  GlobalState globalState = GlobalState.instance;

  donation({api, token, id,projectType,busId,donorName, numberPerson,amount}) async{

    try {

      var response = await http.post(Uri.parse(api),body: {
      'project_id' :  id.toString()!=""? id.toString():"-1",
      'project_type' : projectType.toString(),
      'donor_name' : donorName.toString(),
      'donation_amount' : amount.toString(),
       busId =="" ?'bus_id' : busId.toString():"",
       'number_of_people' : numberPerson.toString() == ""?"" : numberPerson.toString(),
      },headers: {"Authorization":"Bearer "+token.toString()});
      return response.statusCode;

    } catch(e) {
      print(e.toString());
      return 500;
    }
  }


}