part of 'personal_info_bloc.dart';

@immutable
abstract class PersonalInfoState {}

class PersonalInfoInitial extends PersonalInfoState {}

class PersonalInfoSuccess extends PersonalInfoState {
  final User user;

  PersonalInfoSuccess(this.user);
}

class PersonalInfoFailed extends PersonalInfoState {
  final User user;

  PersonalInfoFailed(this.user);
}

class PersonalInfoSaving extends PersonalInfoState {}
