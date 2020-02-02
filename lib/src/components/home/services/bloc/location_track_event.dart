part of 'location_track_bloc.dart';

abstract class LocationTrackEvent extends Equatable {
  const LocationTrackEvent();

  @override
  List<Object> get props => [];
}

class TrackLocation extends LocationTrackEvent {
  final PlacesSearchResult selectedLocation;

  TrackLocation(this.selectedLocation);
}
