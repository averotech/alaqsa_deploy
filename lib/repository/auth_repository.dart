
import 'dart:convert';

import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/standalone.dart' as tz;
import 'package:intl/intl.dart';

class AuthRepository {

  GlobalState globalState = GlobalState.instance;


  register({api,name,email,password,password_confirmation}) async{

    try {
      var response = await http.post(Uri.parse(api),body: {
        "name":name.toString(),
        "email":email.toString(),
        "password":password.toString(),
        "password_confirmation":password_confirmation.toString(),
        "user_role":"user"
      });

      if(response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        var userJson = jsonResponse["user"];
        var userToken = jsonResponse["token"];
        User user = User(userJson["id"], userJson["name"], userJson["email"], "", "", "");
        return [user,userToken];

      } else {
        return [null,""];
      }

    } catch(e) {
      print(e.toString());
      return [null,""];
    }
  }

  registerLoginSocail({api,email,name,socialMediaId}) async{

    try {
      if(email != ""){
        socialMediaId = "-1";
      }
      var response = await http.post(Uri.parse(api),body: {
        "email":email,
        "name":name,
        "social_media_id":socialMediaId
      });

      if(response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        var userJson = jsonResponse["user"];
        var userToken = jsonResponse["token"];
        User user = User(userJson["id"].toString(), userJson["name"].toString(), userJson["email"].toString(), "", "",userJson['fcm_token'].toString());
        return [user,userToken.toString()];
      } else {
        return [null,""];
      }

    } catch(e) {
      print(e.toString());
      return [null,""];
    }
  }

  userInformation({api,token}) async{

    try {
      var response = await http.get(Uri.parse(api),headers: {"Authorization":"Bearer "+token.toString(),"Accept":"application/json"});

      if(response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var userJson = jsonResponse;
        User user = User(userJson["id"], userJson["name"], userJson["email"], "", "", userJson["fcm_token"]);
        return user;

      } else {
        return null;
      }

    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  updateCmFirebaseToken(api,cm_firebase_token,token) async{


    if(token != null){
      var response = await http.put(Uri.parse(api), headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        "fcm_token": cm_firebase_token.toString(),
      });

      if (response.statusCode == 200) {
      } else if (response.statusCode == 401) {}
    }
  }


  removeAccount({api,token}) async{

    try {
      var response = await http.post(Uri.parse(api),headers: {"Authorization":"Bearer "+token.toString(),"Accept":"application/json"});
      if(response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

         return true;

      } else {
        return false;
      }

    } catch(e) {
      print(e.toString());
      return false;
    }
  }
  login({api,required String email, password}) async{

    try {
      Map<String, String> requestBody = {
        "password": password,
      };
      // Determine if the input is an email or a phone number
      if (email.contains('@')) {
        requestBody["email"] = email; // If '@' is present, treat it as an email
      } else {
        requestBody["phone"] = email; // Otherwise, treat it as a phone number
      }
      var response = await http.post(Uri.parse(api),body: requestBody);
      if(response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        var userJson = jsonResponse["user"];
        var userToken = jsonResponse["token"];
        User user = User(userJson["id"].toString(), userJson["name"].toString(), userJson["email"].toString(), "", "",userJson['fcm_token'].toString());
        return [user,userToken.toString()];
      } else {
        return [null,""];
      }

    } catch(e) {
      print(e.toString());
      return [null,""];
    }
  }


  resetPassword({api,required String email}) async {
    try {
      var response = await http.post(
        Uri.parse(api),
        body: {'email': email},
      );
      if (response.statusCode == 200) {
        // Reset password request successful, do nothing (void)
      } else {
        throw Exception('Failed to reset password: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to reset password: $error');
    }
  }
}