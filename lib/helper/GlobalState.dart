
class GlobalState {
  final Map<dynamic,dynamic> _data = <dynamic,dynamic>{};

  static GlobalState instance = new GlobalState._();
  GlobalState._();
  set(dynamic key,dynamic value){
    return _data[key] = value;
  }

  get(dynamic key){
    return _data[key];
  }
  void clear() {
    _data.clear();
  }
}