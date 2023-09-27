import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/models/project.dart';
import 'package:equatable/equatable.dart';


abstract class DonationPageState extends Equatable{
  const DonationPageState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DonationPageInitial extends DonationPageState {
  @override

  DonationPageInitial();
  // TODO: implement props
  List<Object?> get props => [];
}

class DonationChangePrice extends DonationPageState {
  var price;
  DonationChangePrice(this.price);

  @override
  // TODO: implement props
  List<Object?> get props => [price];
}

class DonationPageLoaded extends DonationPageState {
  var trip;
  var user;
  var project;
  DonationPageLoaded.Project(this.project,this.user);
  DonationPageLoaded.Trip(this.trip,this.user);

  @override
  // TODO: implement props
  List<Object?> get props => [trip,project,user];
}


class DonationRequestApiLoaded extends DonationPageState {
  var responseCode;
  DonationRequestApiLoaded(this.responseCode);

  @override
  // TODO: implement props
  List<Object?> get props => [responseCode];
}

class PaypalPaymentState extends DonationPageState {
  var checkoutUrl;
  var returnURL;
  var cancelURL;
  PaypalPaymentState(this.checkoutUrl,this.returnURL,this.cancelURL);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DonationPageErroe extends DonationPageState {
  final error;
  DonationPageErroe(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}




