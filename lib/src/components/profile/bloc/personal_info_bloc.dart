import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stohp/src/models/personal_info.dart';
import 'package:stohp/src/models/user.dart';
import 'package:stohp/src/repository/user_repository.dart';

part 'personal_info_event.dart';
part 'personal_info_state.dart';

class PersonalInfoBloc extends Bloc<PersonalInfoEvent, PersonalInfoState> {
  @override
  PersonalInfoState get initialState => PersonalInfoInitial();
  final UserRepository _userRepository = UserRepository();
  @override
  Stream<PersonalInfoState> mapEventToState(
    PersonalInfoEvent event,
  ) async* {
    if (event is SavePersonalInfo) {
      yield* _mapSavePersonalInfo(event.personalInfo);
    }
  }

  Stream<PersonalInfoState> _mapSavePersonalInfo(
      PersonalInfo personalInfo) async* {
    yield PersonalInfoSaving();
    User updatedUser = await _userRepository.updatePersonalInfo(personalInfo);
    if (updatedUser != null) {
      yield PersonalInfoSuccess(updatedUser);
    } else {
      yield PersonalInfoFailed(updatedUser);
    }
  }
}
