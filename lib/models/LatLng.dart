

class LatLng{
  var _lat;
  var _lng;

  LatLng(this._lat, this._lng);

  get lng => _lng;

  set lng(value) {
    _lng = value;
  }

  get lat => _lat;

  set lat(value) {
    _lat = value;
  }
}