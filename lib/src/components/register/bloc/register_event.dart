import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:stohp/src/models/register_info.dart';

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

class OnFirstNameChanged extends RegisterEvent {
  final String firstName;

  const OnFirstNameChanged({@required this.firstName});

  @override
  List<Object> get props => [firstName];

  @override
  String toString() => 'FirstNameChanged { firstname: $firstName }';
}

class OnLastNameChanged extends RegisterEvent {
  final String lastName;

  const OnLastNameChanged({@required this.lastName});

  @override
  List<Object> get props => [lastName];

  @override
  String toString() => 'lastnameChanged { lastname: $lastName }';
}

class OnEmailChanged extends RegisterEvent {
  final String email;

  const OnEmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { Email: $email }';
}

class OnSubmitted extends RegisterEvent {
  final RegisterInfo userInfo;

  const OnSubmitted({@required this.userInfo});

  @override
  List<Object> get props => [userInfo];

  @override
  String toString() {
    return 'Submitted { username: ${userInfo.username}, password: ${userInfo.password} }';
  }
}
