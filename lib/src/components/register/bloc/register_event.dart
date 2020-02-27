import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class OnUsernameChanged extends RegisterEvent {
  final String email;

  const OnUsernameChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
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
  final String email;
  final String password;

  const OnSubmitted({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password }';
  }
}
