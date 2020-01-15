import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  // TODO: Change in user model
  final String displayName;

  Authenticated(this.displayName);

  @override
  List<Object> get props => [displayName];

  @override
  String toString() => "$displayName is Authenticated";
}

class Unauthenticated extends AuthenticationState {}
