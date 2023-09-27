
import 'dart:convert';
import 'dart:math';

import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
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

class SettingsRepository {

  GlobalState globalState = GlobalState.instance;


  getInformationContactUs({api}) async{
    try {
      var response = await http.get(Uri.parse(api));
      if(response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var data = jsonResponse["data"];
        Map<String,dynamic> contactUS = {
          "phone": data["phone"],
          "email": data["email"],
          "web_url": data["web_url"],
          "location": data["location"]
        };
        return contactUS;
      } else {
        return null;
      }
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  getInformationAboutUs({api}) async{
    try {
      var response = await http.get(Uri.parse(api));
      if(response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var data = jsonResponse["data"];
        var goals = data["goals"];
        List golesList = [];
        if(goals != null) {
        if(goals.isNotEmpty){
          for(var i=0;i<goals.length; i++){
            golesList.add(goals[i]["attributes"]["Goals_section_text"]);
          }
         }
        }


        //
        var achievements = data["achievements"];
        List achievementsList = [];
        if(achievements != null) {
        if(achievements.isNotEmpty){
          for(var i=0;i<achievements.length; i++){
            achievementsList.add(achievements[i]["attributes"]["achievements_section_text"]);
          }
         }
        }

        //
        var workplace = data["workplace"];
        List workplaceList = [];
        if(workplace != null) {
          if(workplace.isNotEmpty){
            for(var i=0;i<workplace.length; i++){
              workplaceList.add(
                  {"text_main_workplace":workplace[i]["data"]["text_main_workplace"],
                    "sup_text_workplace":workplace[i]["data"]["sup_text_workplace"]
                  });
            }
          }
        }

        Map<String,dynamic> aboutUS = {
          "main_text": data["main_text"],
          "sub_main_text": data["sub_main_text"],
          "vision_main": data["vision_main"],
          "vision_sub_text_Main": data["vision_sub_text_Main"],
          "goals_text": "الأهداف",
          "goals": golesList,
          "achievements_text":"أبرز الأعمال",
          "achievements":achievementsList,
          "workplace_text":data["text_main_workplace"],
          "workplace":workplaceList
        };
        return aboutUS;
      } else {
        return null;
      }
    } catch(e) {
      print(e.toString());
      return null;
    }
  }


  sendReportProblem({api,name,numberPhone,textProblem}) async{
    try {
      var response = await http.post(Uri.parse(api),body: {
        "name":name,
        "phone":numberPhone,
        "message":textProblem,
      });

      if(response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch(e) {
      print(e.toString());
      return false;
    }
  }

}