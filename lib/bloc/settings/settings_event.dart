

import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable{

  const SettingsEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GlobalSettingOnClickEvent extends SettingsEvent {
  var avtiveNotfiaction;
  var avtiveSms;
  GlobalSettingOnClickEvent(this.avtiveNotfiaction,this.avtiveSms);

  @override
  // TODO: implement props
  List<Object?> get props => [avtiveNotfiaction,avtiveSms];
}
class GlobalSettingEvent extends SettingsEvent {

  GlobalSettingEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SettingsApiEvent extends SettingsEvent {
  SettingsApiEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class ContactUsEvent extends SettingsEvent {
  ContactUsEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class AboutUsEvent extends SettingsEvent {
  AboutUsEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];

}


class ReportProblemOnClickEvent extends SettingsEvent {
  var name;
  var phoneNumber;
  var messageOnProblem ;
  ReportProblemOnClickEvent(this.name,this.phoneNumber,this.messageOnProblem);
  @override
  // TODO: implement props
  List<Object?> get props => [name,phoneNumber,messageOnProblem];

}

class ReportProblemEvent extends SettingsEvent {
  ReportProblemEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

