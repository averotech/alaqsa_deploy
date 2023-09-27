
import 'dart:convert';

import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/standalone.dart' as tz;
import 'package:intl/intl.dart';

class ProjectRepository {

  GlobalState globalState = GlobalState.instance;

  getProjects(api,token) async{
    List<Project> projectsList = <Project>[];
    try {

      var response;
      if(token != "" && token.toString() != "null"){
        response = await http.get(Uri.parse(api),headers: {"Authorization":"Bearer "+token.toString()});
      } else{
         response = await http.get(Uri.parse(api));
      }


      if(response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        var data = jsonResponse["data"]["data"];
        var nextPage = jsonResponse["data"]["next_page_url"];

        if(data.isNotEmpty) {
          for(var i=0;i<data.length;i++){
            Project project = Project.fromJson(data[i]);
            projectsList.add(project);
          }

          if(nextPage != null && nextPage.toString() != null) {
            return [projectsList,nextPage];
          } else {
            return [projectsList,"null"];
          }

        } else {
          return [projectsList,"null"];
        }
      } else {
        return [projectsList,"null"];
      }
    } catch(e) {
      print(e.toString());
      return [projectsList,"null"];
    }
  }

  getDetailProjectNews(){
    if(globalState.get("project") != null) {
      Project project = globalState.get("project");
      if(project.publicationStatus){
        return project;
      }
      return null;
    }
    return null;

  }


  volunteer({api, token, id}) async{

    try {
      var response = await http.post(Uri.parse(api),body: {
        'project_id' : id.toString(),
      },headers: {"Authorization":"Bearer "+token.toString()});
        return response.statusCode;
    } catch(e) {
      print(e.toString());
      return 500;
    }
  }

  cancleVolunteer({api, token, id}) async{

    try {
      var response = await http.post(Uri.parse(api),body: {
        'id' : id.toString(),
      },headers: {"Authorization":"Bearer "+token.toString()});

      return response.statusCode;
    } catch(e) {
      print(e.toString());
      return 500;
    }
  }


}