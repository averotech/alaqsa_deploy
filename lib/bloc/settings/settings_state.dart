import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/models/user.dart';
import 'package:alaqsa/models/user_profile.dart';
import 'package:equatable/equatable.dart';


abstract class SettingsState extends Equatable{
  const SettingsState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GlobalSettingLoaded extends SettingsState {
  var avtiveNotfiaction;
  var avtiveSms;
  GlobalSettingLoaded(this.avtiveNotfiaction,this.avtiveSms);
  @override
  // TODO: implement props
  List<Object?> get props => [avtiveNotfiaction,avtiveSms];
}


class AboutUSLoaded extends SettingsState {
  Map<String,dynamic> aboutUs;
  AboutUSLoaded(this.aboutUs);
  @override
  // TODO: implement props
  List<Object?> get props => [aboutUs];
}


class ContactUSLoaded extends SettingsState {
  Map<String,dynamic> contactUs;

  ContactUSLoaded(this.contactUs);
  @override
  // TODO: implement props
  List<Object?> get props => [contactUs];
}


class ReportProblemLoaded extends SettingsState {
  User user;
  ReportProblemLoaded(this.user);
  @override
  // TODO: implement props
  List<Object?> get props => [this.user];
}


class ReportProblemSendLoaded extends SettingsState {
  var isSuccess;
  ReportProblemSendLoaded(this.isSuccess);
  @override
  // TODO: implement props
  List<Object?> get props => [isSuccess];
}



class SettingsSendReportError extends SettingsState {
  final error;
  SettingsSendReportError(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}


class SettingsError extends SettingsState {
  final error;
  SettingsError(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}


