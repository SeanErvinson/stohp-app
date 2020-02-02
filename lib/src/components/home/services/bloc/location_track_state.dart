part of 'location_track_bloc.dart';

abstract class LocationTrackState extends Equatable {
  const LocationTrackState();
  @override
  List<Object> get props => [];
}

class LocationTrackInitial extends LocationTrackState {}

class LocationRunning extends LocationTrackState {
  final String location;

  LocationRunning(this.location);
}
