

import 'dart:convert';

import 'package:alaqsa/models/MYLoaction.dart';

class Bus {
  var _id;
  var _nameDriver;
  var _busNumber;
  var _phone_number_driver;
  var _status;
  var _numberOfSeats;
  MYLoaction _startPoint;
  MYLoaction _endPoint;

  Bus(this._id, this._nameDriver, this._busNumber, this._phone_number_driver,
      this._status,this._numberOfSeats, this._startPoint, this._endPoint);


  factory Bus.fromJson(Map<String,dynamic> json){
    var jsonStartPoint;
    var jsonEndPoint;


    if(json["travelfrom"] != null) {
      jsonStartPoint = json["travelfrom"]["current_location"];
    }

    if(json["travelto"] != null) {
      jsonEndPoint = json["travelto"]["current_location"];
    }

    return Bus(json["id"], json["name_driver"], json["bus_number"], json["phone_number_driver"], json["status"],json["number_of_seats"], jsonStartPoint != null ?MYLoaction.fromJson(jsonStartPoint):MYLoaction.IsEmpty(), jsonEndPoint != null ?MYLoaction.fromJson(jsonEndPoint):MYLoaction.IsEmpty());
  }

  MYLoaction get endPoint => _endPoint;

  set endPoint(MYLoaction value) {
    _endPoint = value;
  }

  MYLoaction get startPoint => _startPoint;

  set startPoint(MYLoaction value) {
    _startPoint = value;
  }

  get status => _status;

  set status(value) {
    _status = value;
  }

  get phone_number_driver => _phone_number_driver;

  set phone_number_driver(value) {
    _phone_number_driver = value;
  }

  get busNumber => _busNumber;

  set busNumber(value) {
    _busNumber = value;
  }

  get nameDriver => _nameDriver;

  set nameDriver(value) {
    _nameDriver = value;
  }

  get id => _id;

  set id(value) {
    _id = value;
  }

  get numberOfSeats => _numberOfSeats;

  set numberOfSeats(value) {
    _numberOfSeats = value;
  }
}