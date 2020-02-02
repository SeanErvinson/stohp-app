import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:equatable/equatable.dart';
import 'package:stohp/src/repository/places_repository.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlacesRepository _placesRepository;

  PlaceBloc({PlacesRepository placesRepository})
      : _placesRepository = placesRepository;

  @override
  PlaceState get initialState => SearchInitial();

  @override
  Stream<PlaceState> transformEvents(
    Stream<PlaceEvent> events,
    Stream<PlaceState> Function(PlaceEvent event) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! OnSearchPlaceChange);
    });
    final debounceStream = events.where((event) {
      return (event is OnSearchPlaceChange);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<PlaceState> mapEventToState(
    PlaceEvent event,
  ) async* {
    yield SearchLoading();
    if (event is OnSearchPlaceChange) {
      yield* _mapSearchLocationChange(event.location);
    } else if (event is OnSubmitted) {
      yield* _mapSearchSubmitted(event.location);
    }
  }

  Stream<PlaceState> _mapSearchLocationChange(String location) async* {
    if (location.length <= 0) return;
    List<PlacesSearchResult> places =
        await _placesRepository.fetchPlaces(location);
    yield SearchLoaded(places);
  }

  Stream<PlaceState> _mapSearchSubmitted(String location) async* {
    yield SearchLoading();
  }
}
