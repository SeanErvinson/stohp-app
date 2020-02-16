part of 'location_track_bloc.dart';

abstract class LocationTrackState extends Equatable {
  const LocationTrackState();
  @override
  List<Object> get props => [];
}

class LocationTrackInitial extends LocationTrackState {}

class LocationRunning extends LocationTrackState {
  final Place destination;
  final Place source;
  final Distance distance;
  final List<LatLng> polylineCoordinates;

  LocationRunning(
      this.destination, this.source, this.distance, this.polylineCoordinates);

  @override
  List<Object> get props =>
      [destination, source, distance, polylineCoordinates];
}
