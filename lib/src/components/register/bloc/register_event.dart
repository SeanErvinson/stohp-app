import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class OnUsernameChanged extends RegisterEvent {
  final String username;

  const OnUsernameChanged({@required this.username});

  @override
  List<Object> get props => [username];

  @override
  String toString() => 'Username changed { username :$username }';
}

class OnPasswordChanged extends RegisterEvent {
  final String password;

  const OnPasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class OnSubmitted extends RegisterEvent {
  final String username;
  final String password;

  const OnSubmitted({
    @required this.username,
    @required this.password,
  });

  @override
  List<Object> get props => [username, password];

  @override
  String toString() {
    return 'Submitted { username: $username, password: $password }';
  }
}
