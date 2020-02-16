part of 'location_track_bloc.dart';

abstract class LocationTrackEvent extends Equatable {
  const LocationTrackEvent();

  @override
  List<Object> get props => [];
}

class CancelTracking extends LocationTrackEvent {}

class StartTracking extends LocationTrackEvent {
  final Place selectedPlace;

  StartTracking(this.selectedPlace);
}

class UpdateTracking extends LocationTrackEvent {
  final Position currentPosition;

  UpdateTracking(this.currentPosition);
}
