import 'package:intl/intl.dart';


class Donatione {
  var _id;
  var _totalAmount;
  var _sectorProject;
  var _donationType;
  var _donationDate;


  Donatione(this._id, this._totalAmount, this._sectorProject,
      this._donationType, this._donationDate);


  factory Donatione.fromJson(Map<String,dynamic> json) {
    var createdAtDate = "";
    var outputFormat = DateFormat('yyyy-MM-dd');
    if(json["created_at"] != null && json["created_at"] != "null") {
      DateTime dtf = DateTime.parse(json["created_at"]);
      createdAtDate = outputFormat.format(dtf);
    }
    return Donatione(json["id"], json["amount"], json["project"] != null?json["project"]["sector"]:"تبرعات عامة", json["project_type"].toString() == "1"?"مشاريع":json["project_type"].toString() == "2"?"رحلات":"غير معروف" , createdAtDate);
  }



  get id => _id;

  set id(value) {
    _id = value;
  }

  get totalAmount => _totalAmount;

  get donationDate => _donationDate;

  set donationDate(value) {
    _donationDate = value;
  }

  get donationType => _donationType;

  set donationType(value) {
    _donationType = value;
  }

  get sectorProject => _sectorProject;

  set sectorProject(value) {
    _sectorProject = value;
  }

  set totalAmount(value) {
    _totalAmount = value;
  }
}