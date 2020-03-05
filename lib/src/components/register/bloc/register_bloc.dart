import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stohp/src/components/register/bloc/bloc.dart';
import 'package:stohp/src/models/register_info.dart';
import 'package:stohp/src/repository/user_repository.dart';
import 'package:stohp/src/validation/validators.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> transformEvents(
    Stream<RegisterEvent> events,
    Stream<RegisterState> Function(RegisterEvent event) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! OnUsernameChanged &&
          event is! OnPasswordChanged &&
          event is! OnEmailChanged &&
          event is! OnFirstNameChanged &&
          event is! OnLastNameChanged);
    });
    final debounceStream = events.where((event) {
      return (event is OnUsernameChanged ||
          event is OnPasswordChanged ||
          event is OnEmailChanged ||
          event is OnFirstNameChanged ||
          event is OnLastNameChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is OnUsernameChanged) {
      yield* _mapUsernameChangedToState(event.username);
    } else if (event is OnPasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is OnEmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is OnFirstNameChanged) {
      yield* _mapFirstNameChangedToState(event.firstName);
    } else if (event is OnLastNameChanged) {
      yield* _mapLastNameChangedToState(event.lastName);
    } else if (event is OnSubmitted) {
      yield* _mapFormSubmittedToState(event.userInfo);
    }
  }

  Stream<RegisterState> _mapUsernameChangedToState(String username) async* {
    yield state.update(
      isUsernameValid: Validators.isValidUsername(username),
    );
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapFirstNameChangedToState(String firstName) async* {
    yield state.update(
      isFirstNameValid: Validators.isValidName(firstName),
    );
  }

  Stream<RegisterState> _mapLastNameChangedToState(String lastName) async* {
    yield state.update(
      isLastNameValid: Validators.isValidName(lastName),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapFormSubmittedToState(RegisterInfo userInfo) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.registerUser(userInfo);
      String token = await _userRepository.authenticate(
          username: userInfo.username, password: userInfo.password);
      _userRepository.persistToken(token);
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}
