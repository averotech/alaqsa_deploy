

import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:equatable/equatable.dart';

abstract class DonationPageEvent extends Equatable{

  const DonationPageEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DonationPageInitialEvent extends DonationPageEvent {

  DonationPageInitialEvent();

}


class DonationPageRequestApiEvent extends DonationPageEvent {

  var projectId;
  var projectType;
  var busId;
  var amount;
  var donorName;
  var numberOfPeople;
  var _nameCard;
  var _numberCard;
  var _expiryDate;
  var _cvv;



  DonationPageRequestApiEvent(this.projectId,this.projectType,this.busId,this.amount,this.donorName,this.numberOfPeople,this._nameCard,this._numberCard,this._expiryDate,this._cvv);

  get nameCard => _nameCard;

  @override
  // TODO: implement props
  List<Object?> get props => [projectId,projectType,busId,amount,donorName,numberOfPeople];

  get numberCard => _numberCard;

  get expiryDate => _expiryDate;

  get cvv => _cvv;
}
class DonationPageTextEditionTotalAmountEvent extends DonationPageEvent {

  var totalAmount;
  DonationPageTextEditionTotalAmountEvent(this.totalAmount);

  @override
  // TODO: implement props
  List<Object?> get props => [totalAmount];
}


class PaypalPaymentEvent extends DonationPageEvent {

  var nameProject;
  var totalPrice;
  var numberOfPeople;

  PaypalPaymentEvent(this.nameProject,this.totalPrice,this.numberOfPeople);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}






