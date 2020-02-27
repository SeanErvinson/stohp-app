part of 'greet_bloc.dart';

@immutable
abstract class GreetState {}

class GreetInitial extends GreetState {}

class GreetMorning extends GreetState {}

class GreetAfternoon extends GreetState {}

class GreetEvening extends GreetState {}
