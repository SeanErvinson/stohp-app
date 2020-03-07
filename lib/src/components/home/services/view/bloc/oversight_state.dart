part of 'oversight_bloc.dart';

@immutable
abstract class OversightState {}

class OversightInitial extends OversightState {}

class OversightUpdate extends OversightState {
  final Position currentPosition;

  OversightUpdate(this.currentPosition);
}
