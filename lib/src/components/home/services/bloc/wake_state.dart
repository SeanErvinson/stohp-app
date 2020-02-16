part of 'wake_bloc.dart';

abstract class WakeState extends Equatable {
  const WakeState();
  @override
  List<Object> get props => [];
}

class WakeInitial extends WakeState {}

class WakeRunning extends WakeState {
  final Place destination;
  final Place source;
  final Distance distance;
  final List<LatLng> polylineCoordinates;

  WakeRunning(
      this.destination, this.source, this.distance, this.polylineCoordinates);

  @override
  List<Object> get props =>
      [destination, source, distance, polylineCoordinates];
}
