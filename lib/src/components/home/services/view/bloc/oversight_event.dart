part of 'oversight_bloc.dart';

@immutable
abstract class OversightEvent {}

class ConnectRoom extends OversightEvent {}

class UpdateFilter extends OversightEvent {
  final OversightFilter filter;

  UpdateFilter(this.filter);
}

class UpdateDriverPosition extends OversightEvent {
  final DriverOversightInfo driverInfo;

  UpdateDriverPosition(this.driverInfo);
}

class UpdateCommuterPosition extends OversightEvent {
  final Position position;

  UpdateCommuterPosition(this.position);
}

class DisconnectRoom extends OversightEvent {}
