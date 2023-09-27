import 'package:intl/intl.dart';

class News {
  var _id;
  var _title;
  var _description;
  var _content;
  var _imageNews;
  var _pictures;
  var _date;

  News(this._id, this._title, this._description, this._content, this._imageNews, this._pictures,this._date);

  get pictures => _pictures;

  set pictures(value) {
    _pictures = value;
  }

  get imageNews => _imageNews;

  set imageNews(value) {
    _imageNews = value;
  }

  get content => _content;

  set content(value) {
    _content = value;
  }

  get description => _description;

  set description(value) {
    _description = value;
  }

  get title => _title;

  set title(value) {
    _title = value;
  }

  get id => _id;

  set id(value) {
    _id = value;
  }


  get date => _date;

  set date(value) {
    _date = value;
  }

  factory News.fromJson(Map<String,dynamic> json) => News(
      json["id"],
      json["title"],
      json["description"],
      json["contents"],
      json["image"],
      json["pictures"],
      json["created_at"],
  );



  factory News.fromProjectJson(Map<String,dynamic> json) {

    var createdAtDate = "";
    var outputFormat = DateFormat('yyyy-MM-dd');
    if(json["report_date"] != null && json["report_date"] != "null") {
      DateTime dtf = DateTime.parse(json["report_date"]);
      createdAtDate = outputFormat.format(dtf);
    }

    return News(
      json["id"],
      json["report_title"],
      json["report_description"],
      json["report_contents"],
      json["report_image"],
      json["report_pictures"],
      createdAtDate.toString(),
    );
  }


}