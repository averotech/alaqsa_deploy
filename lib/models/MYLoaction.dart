


import 'package:timezone/standalone.dart';

class MYLoaction{
  var _lat;
  var _lng;
  var _addressLocation;
  var _distanseLocation;

  MYLoaction(this._lat, this._lng, this._addressLocation, this._distanseLocation);

  MYLoaction.IsEmpty();
  get distanseLocation => _distanseLocation;

  set distanseLocation(value) {
    _distanseLocation = value;
  }

  get addressLocation => _addressLocation;

  set addressLocation(value) {
    _addressLocation = value;
  }

  get lng => _lng;

  set lng(value) {
    _lng = value;
  }

  get lat => _lat;

  set lat(value) {
    _lat = value;
  }
  
 factory MYLoaction.fromJson(Map<String,dynamic> json) {
    return MYLoaction(json['latitude'], json['longitude'], json['formatted_address'].toString() != "null"? json['formatted_address'].toString():json['city'].toString(), 0.0);
  }
}