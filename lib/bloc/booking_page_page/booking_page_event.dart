

import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:equatable/equatable.dart';

abstract class BookingPageEvent extends Equatable{

  const BookingPageEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BookingPageInitialEvent extends BookingPageEvent {
  var _isRefresh = false;
  BookingPageInitialEvent(this._isRefresh);
  get isRefresh => _isRefresh;

}


class BookingPageSelectedBusEvent extends BookingPageEvent {
  var _bus;
  BookingPageSelectedBusEvent(this._bus);
  get bus => _bus;

}



class BookingTripEvent extends BookingPageEvent {
  var _tripId;
  var _busId;
  var _numberPerson;
  var _numberPhone;
  BookingTripEvent(this._tripId,this._busId,this._numberPerson,this._numberPhone);

  get numberPhone => _numberPhone;

  set numberPhone(value) {
    _numberPhone = value;
  }

  get numberPerson => _numberPerson;

  set numberPerson(value) {
    _numberPerson = value;
  }

  get busId => _busId;

  set busId(value) {
    _busId = value;
  }

  get tripId => _tripId;

  set tripId(value) {
    _tripId = value;
  }
}

class BookingTripSuccessEvent extends BookingPageEvent {

  BookingTripSuccessEvent();

}

class CancleBookingTripEvent extends BookingPageEvent {
  var _tripId;
  var _index;
  CancleBookingTripEvent(this._tripId,this._index);
  get tripId => _tripId;
  get index => _index;

}

class BookingPageSearchCityEvent extends BookingPageEvent {

  var _search;
  BookingPageSearchCityEvent(this._search);

  get search => _search;
}

