import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stohp/src/models/user.dart';
import 'package:stohp/src/repository/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'authentication_state.dart';
part 'authentication_event.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    final String token = await _userRepository.getToken();

    if (token != null) {
      try {
        User user = await _userRepository.getUser(token);
        yield Authenticated(user);
      } catch (_) {
        yield Unauthenticated();
      }
    } else {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    String token = await _userRepository.getToken();
    User user = await _userRepository.getUser(token);
    yield (Authenticated(user));
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield (Unauthenticated());
    await _userRepository.deleteToken();
  }
}
