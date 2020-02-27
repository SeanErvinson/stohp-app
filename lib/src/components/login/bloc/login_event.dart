import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class OnUsernameChanged extends LoginEvent {
  final String username;

  const OnUsernameChanged({@required this.username});

  @override
  List<Object> get props => [username];

  @override
  String toString() => 'UsernameChanged { email :$username }';
}

class OnPasswordChanged extends LoginEvent {
  final String password;

  const OnPasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password :$password }';
}

class OnSumbitted extends LoginEvent {
  final String username;
  final String password;

  const OnSumbitted({
    @required this.username,
    @required this.password,
  });

  @override
  List<Object> get props => [username, password];

  @override
  String toString() {
    return 'Submitted { email: $username, password: $password }';
  }
}

class LoginWithGooglePressed extends LoginEvent {}

class LoginWithCredentialsPressed extends LoginEvent {
  final String username;
  final String password;

  const LoginWithCredentialsPressed({
    @required this.username,
    @required this.password,
  });

  @override
  List<Object> get props => [username, password];

  @override
  String toString() {
    return 'LoginWithCredentialsPressed { email: $username, password: $password }';
  }
}
