

import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/donatione.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/models/user.dart';
import 'package:alaqsa/models/volunteer.dart';

class UserProfile {
  User _user;
  List<Donatione> _myDonationes;
  List<Volunteer> _myVolunteers;
  List<Trip> _myTrips;
  var _donationCount;
  var _volunteerCount;
  var _tripCount;

  UserProfile(this._user, this._myDonationes, this._myVolunteers, this._myTrips,this._donationCount,this._tripCount,this._volunteerCount);

  List<Trip> get myTrips => _myTrips;

  List<Volunteer> get myVolunteers => _myVolunteers;

  List<Donatione> get myDonationes => _myDonationes;

  User get user => _user;

  get tripCount => _tripCount;

  get volunteerCount => _volunteerCount;

  get donationCount => _donationCount;
}