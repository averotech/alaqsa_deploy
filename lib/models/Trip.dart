import 'dart:convert';

import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/MYLoaction.dart';
import 'package:alaqsa/models/bus.dart';
import 'package:alaqsa/models/project.dart';
import 'package:intl/intl.dart';

class Trip extends Project {
  var _id;
  var _nameTrip;
  var _descriptionTrip;
  var _is_volunteer;
  var _is_donation;
  var _startDate;
  var _endDate;
  var _nameDate;
  var _city;
  List<Bus> _litsBus;
  MYLoaction _from;
  MYLoaction _to;
  var _fromDistance;
  var _toDistance;
  bool isOpen;
  bool _isBooking;
  var _tripToLocation;
  var _tripFromLocation;
  bool _isFull;
  Trip(
    this._id,
    this._nameTrip,
    this._descriptionTrip,
    this._is_volunteer,
    this._is_donation,
    this._startDate,
    this._endDate,
    this._nameDate,
    this._city,
    this._litsBus,
    this._from,
    this._to,
    this._fromDistance,
    this._toDistance,
    this.isOpen,
    this._isBooking,
    this._tripToLocation,
    this._tripFromLocation,
    this._isFull,
  ) : super.fromProject(_id, _nameTrip, _descriptionTrip, _is_volunteer,
            _is_donation, _startDate, _endDate, false);

  MYLoaction get from => _from;

  set from(MYLoaction value) {
    _from = value;
  }

  get descriptionTrip => _descriptionTrip;

  set descriptionTrip(value) {
    _descriptionTrip = value;
  }

  get nameTrip => _nameTrip;

  set nameTrip(value) {
    _nameTrip = value;
  }

  get nameDate => _nameDate;

  set nameDate(value) {
    _nameDate = value;
  }

  bool get isBooking => _isBooking;

  set isBooking(bool value) {
    _isBooking = value;
  }

  bool get isFull => _isFull;

  set isFull(bool value) {
    _isFull = value;
  }

  List<Bus> get litsBus => _litsBus;

  set litsBus(List<Bus> value) {
    _litsBus = value;
  }

  get city => _city;

  set city(value) {
    _city = value;
  }

  get fromDistance => _fromDistance;

  set fromDistance(value) {
    _fromDistance = value;
  }

  MYLoaction get to => _to;

  set to(MYLoaction value) {
    _to = value;
  }

  get tripToLocation => _tripToLocation;

  set tripToLocation(value) {
    _tripToLocation = value;
  }

  get tripFromLocation => _tripFromLocation;

  set tripFromLocation(value) {
    _tripFromLocation = value;
  }

  factory Trip.fromJson(Map<String, dynamic> json) {
    var startDate = "";
    var endDate = "";
    String? nameDate = "";
    var outputFormat = DateFormat('yyyy-MM-dd hh:mm:ss');
    var jsonTripFrom;
    var jsonTripTo;
    var city = "";
    bool isFull = false;
    if (json["start_date"] != null && json["start_date"] != "null") {
      DateTime dtf = DateTime.parse(json["start_date"]);

      if (dtf != null) {
        nameDate = Config.weekdayName[dtf.weekday];
      }

      startDate = outputFormat.format(dtf);
    }

    if (json["end_date"] != null && json["end_date"] != "null") {
      DateTime dtf = DateTime.parse(json["end_date"]);
      endDate = outputFormat.format(dtf);
    }

    if (json["tripto"] != null) {
      jsonTripTo = json["tripto"]["current_location"];
    }

    if (json["tripfrom"] != null) {
      jsonTripFrom = json["tripfrom"]["current_location"];
    }

    if (json["trip_city"] != null) {
      city = json["trip_city"]["city"]["name"];
    }

    List jsonBus = json["bus_trip"];
    List<Bus> listBus = [];

    if (jsonBus != null) {
      if (jsonBus.isNotEmpty) {
        for (var i = 0; i < jsonBus.length; i++) {
          Bus bus = Bus.fromJson(jsonBus[i]);
          listBus.add(bus);
        }
      }
    }

    return Trip(
      json['id'],
      json['project_name'],
      json['project_describe'],
      json['is_volunteer'].toString() == "1" ? true : false,
      json['is_donation'].toString() == "1" ? true : false,
      startDate,
      endDate,
      nameDate,
      city,
      listBus,
      jsonTripFrom != null
          ? MYLoaction.fromJson(jsonTripFrom)
          : MYLoaction.IsEmpty(),
      jsonTripTo != null
          ? MYLoaction.fromJson(jsonTripTo)
          : MYLoaction.IsEmpty(),
      json["from_distance"],
      json["to_distance"],
      false,
      json["isBooking"].toString() == "1" ? true : false,
      json["tripToLocation"],
      json["tripFromLocation"],
        json['isFull'].toString() == "1" ? true : false,

    );
  }

  @override
  get startDate {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime newStartDate = DateTime.parse(_startDate);
    var startDateWithoutTime = dateFormat.format(newStartDate).toString();
    return startDateWithoutTime;
  }

  get startTime {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm:ss");
    DateTime dateTime = dateFormat.parse(_startDate);

    var startTime =
        "${dateTime.hour > 9 ? dateTime.hour : "0" + dateTime.hour.toString()}" +
            ":" +
            "${dateTime.minute > 9 ? dateTime.minute : "0" + dateTime.minute.toString()}";

    return startTime;
  }

  get endTime {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm:ss");
    DateTime dateTime = dateFormat.parse(_endDate);
    var endTime =
        "${dateTime.hour > 9 ? dateTime.hour : "0" + dateTime.hour.toString()}" +
            ":" +
            "${dateTime.minute > 9 ? dateTime.minute : "0" + dateTime.minute.toString()}";
    return endTime;
  }

  get toDistance => _toDistance;

  set toDistance(value) {
    _toDistance = value;
  }
}
