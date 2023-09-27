

class PaymentMethods {
  var _id;
  var _typeCard;
  var _namePerson;
  var _numberCard;
  var _expiryDate;
  var _ccv;

  PaymentMethods(this._id, this._typeCard, this._namePerson, this._numberCard,
      this._expiryDate, this._ccv);

  get ccv => _ccv;

  set ccv(value) {
    _ccv = value;
  }

  get expiryDate => _expiryDate;

  set expiryDate(value) {
    _expiryDate = value;
  }

  get numberCard => _numberCard;

  set numberCard(value) {
    _numberCard = value;
  }

  get namePerson => _namePerson;

  set namePerson(value) {
    _namePerson = value;
  }

  get typeCard => _typeCard;

  set typeCard(value) {
    _typeCard = value;
  }

  get id => _id;

  set id(value) {
    _id = value;
  }
}