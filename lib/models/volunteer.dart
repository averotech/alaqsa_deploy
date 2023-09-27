
import 'package:intl/intl.dart';
import 'package:alaqsa/models/project.dart';

class Volunteer {

  var _id;
  var _statusVolunteer;
  Project _project;
  var _created_at;
  Volunteer(this._id, this._statusVolunteer, this._project,this._created_at);


 factory Volunteer.fromJson(Map<String,dynamic> json) {
   var created_at = "";
   var outputFormat = DateFormat('yyyy-MM-dd');
   if(json["created_at"] != null && json["created_at"] != "null") {
     DateTime dtf = DateTime.parse(json["created_at"]);
     created_at = outputFormat.format(dtf);
   }

    return Volunteer(json["id"], json["status"], json["project"] != null ?Project.fromJson(json["project"]):Project.IsEmpty(),created_at);
  }

  Project get project => _project;

  set project(Project value) {
    _project = value;
  }

  get statusVolunteer => _statusVolunteer;

  set statusVolunteer(value) {
    _statusVolunteer = value;
  }

  get id => _id;

  set id(value) {
    _id = value;
  }

  get created_at => _created_at;

  set created_at(value) {
    _created_at = value;
  }
}