

class Setting {
  var _aboutUs;
  var _phone;
  var _email;
  var _facebook;
  var _instagram;
  var _twitter;

  Setting(this._aboutUs, this._phone, this._email, this._facebook,
      this._instagram, this._twitter);

  get twitter => _twitter;

  set twitter(value) {
    _twitter = value;
  }

  get instagram => _instagram;

  set instagram(value) {
    _instagram = value;
  }

  get facebook => _facebook;

  set facebook(value) {
    _facebook = value;
  }

  get email => _email;

  set email(value) {
    _email = value;
  }

  get phone => _phone;

  set phone(value) {
    _phone = value;
  }

  get aboutUs => _aboutUs;

  set aboutUs(value) {
    _aboutUs = value;
  }
}