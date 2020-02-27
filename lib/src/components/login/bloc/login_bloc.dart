import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stohp/src/repository/user_repository.dart';
import 'package:stohp/src/validation/validators.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;

  @override
  LoginState get initialState => LoginState.empty();

  LoginBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  Stream<LoginState> transformEvents(
    Stream<LoginEvent> events,
    Stream<LoginState> Function(LoginEvent event) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! OnUsernameChanged && event is! OnPasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is OnUsernameChanged || event is OnPasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is OnUsernameChanged) {
      yield* _mapUsernameChangedToState(event.username);
    } else if (event is OnPasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.username,
        password: event.password,
      );
    }
  }

  Stream<LoginState> _mapUsernameChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginState.loading();
    try {
      final token = await _userRepository.authenticate(
        username: email,
        password: password,
      );
      await _userRepository.persistToken(token);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}
