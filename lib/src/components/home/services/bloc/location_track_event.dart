part of 'location_track_bloc.dart';

abstract class LocationTrackEvent extends Equatable {
  const LocationTrackEvent();

  @override
  List<Object> get props => [];
}

class TrackLocation extends LocationTrackEvent {
  final Place selectedPlace;

  TrackLocation(this.selectedPlace);
}

class CancelTrackLocation extends LocationTrackEvent {}

class LocationUpdate extends LocationTrackEvent {}

class UpdateTrackLocation extends LocationTrackEvent {
  final Position currentPosition;

  UpdateTrackLocation(this.currentPosition);
}
