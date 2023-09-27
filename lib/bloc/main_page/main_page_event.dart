

import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:equatable/equatable.dart';

abstract class MainPageEvent extends Equatable{

  const MainPageEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MainPageInitialEvent extends MainPageEvent {
  MainPageInitialEvent();
}



class UpdateCmFirbaseEvent extends MainPageEvent {
  var cmFirebaseToken;
  UpdateCmFirbaseEvent(this.cmFirebaseToken);
}


class MainPageApiEvent extends MainPageEvent {

   MainPageApiEvent();


  @override
  // TODO: implement props
  List<Object?> get props => [];

}

