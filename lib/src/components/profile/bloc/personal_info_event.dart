part of 'personal_info_bloc.dart';

@immutable
abstract class PersonalInfoEvent {}

class SavePersonalInfo extends PersonalInfoEvent {
  final PersonalInfo personalInfo;

  SavePersonalInfo(this.personalInfo);
}