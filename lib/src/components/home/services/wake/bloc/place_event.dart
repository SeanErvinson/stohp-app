part of 'place_bloc.dart';

abstract class PlaceEvent extends Equatable {
  const PlaceEvent();

  @override
  List<Object> get props => null;
}

class OnSearchPlaceChange extends PlaceEvent {
  final String location;

  const OnSearchPlaceChange({@required this.location});
}

class OnSubmitted extends PlaceEvent {
  final String location;

  const OnSubmitted({@required this.location});
}
