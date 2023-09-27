import 'package:intl/intl.dart';
import 'package:alaqsa/models/news.dart';

class Project {
  var _id;
  var _nameProject;
  var _descriptionProject;
  var _imageProject;
  var _is_bus;
  var _is_volunteer;
  var _is_donation;
  var _publicationStatus;
  var _sector;
  var _startDate;
  var _endDate;
  late News _news;
  var _is_volunteer_user;
  var _location;
  Project(
      this._id,
      this._nameProject,
      this._descriptionProject,
      this._imageProject,
      this._is_bus,
      this._is_volunteer,
      this._is_donation,
      this._publicationStatus,
      this._sector,
      this._startDate,
      this._endDate,
      this._news,this._is_volunteer_user,this._location);


  Project.IsEmpty();
  Project.fromProject(this._id,
  this._nameProject,
  this._descriptionProject,
  this._is_volunteer,
  this._is_donation,
  this._startDate,
  this._endDate,this._is_volunteer_user);

  News get news => _news;

  set news(News value) {
    _news = value;
  }

  get publicationStatus => _publicationStatus;

  set publicationStatus(value) {
    _publicationStatus = value;
  }

  get is_donation => _is_donation;

  set is_donation(value) {
    _is_donation = value;
  }

  get is_volunteer => _is_volunteer;

  set is_volunteer(value) {
    _is_volunteer = value;
  }

  get is_bus => _is_bus;

  set is_bus(value) {
    _is_bus = value;
  }

  get imageProject => _imageProject;

  set imageProject(value) {
    _imageProject = value;
  }

  get descriptionProject => _descriptionProject;

  set descriptionProject(value) {
    _descriptionProject = value;
  }

  get nameProject => _nameProject;

  set nameProject(value) {
    _nameProject = value;
  }

  get id => _id;

  set id(value) {
    _id = value;
  }

  get sector => _sector;

  set sector(value) {
    _sector = value;
  }

  factory Project.fromJson(Map<String,dynamic> data) {
    var startDate = "";
    var endDate = "";

    var outputFormat = DateFormat('yyyy-MM-dd');
    if(data["start_date"] != null && data["start_date"] != "null") {

      DateTime dtf = DateTime.parse(data["start_date"]);
      startDate =  outputFormat.format(dtf);

    }

    if(data["end_date"] != null && data["end_date"] != "null") {
      DateTime dtf = DateTime.parse(data["end_date"]);
      endDate =  outputFormat.format(dtf);;
    }
    return Project(data['id'], data['project_name'], data['project_describe'],  data['project_image'],  data['is_bus'].toString() == "1"? true:false, data['is_volunteer'].toString() == "1" ?true:false, data['is_donation'].toString() == "1"?true:false, data['report_status'].toString() == "1"?true:false,data['sector'],startDate,endDate, News.fromProjectJson(data),data['is_volunteer_user'].toString() =="1"?true:false,data["projectCities"].toString());
  }

  get startDate => _startDate;

  set startDate(value) {
    _startDate = value;
  }


  get endDate => _endDate;

  set endDate(value) {
    _endDate = value;
  }

  get is_volunteer_user => _is_volunteer_user;

  set is_volunteer_user(value) {
    _is_volunteer_user = value;
  }

  get location => _location;

  set location(value) {
    _location = value;
  }
}