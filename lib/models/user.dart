

class User {
  var _id;
  var _name;
  var _email;
  var _phoen;
  var _photo;
  var _fcmToken;


  User(this._id, this._name, this._email, this._phoen, this._photo,
      this._fcmToken);


  factory User.fromJson(Map<String,dynamic> json) => User(json["id"], json["name"], json["email"], json["phone"] ?? "", json["photo"] ?? "", json["fcm_token"]);

  get fcmToken => _fcmToken;

  set fcmToken(value) {
    _fcmToken = value;
  }

  get photo => _photo;

  set photo(value) {
    _photo = value;
  }

  get phoen => _phoen;

  set phoen(value) {
    _phoen = value;
  }

  get email => _email;

  set email(value) {
    _email = value;
  }

  get name => _name;

  set name(value) {
    _name = value;
  }

  get id => _id;

  set id(value) {
    _id = value;
  }
}