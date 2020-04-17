import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:stohp/src/components/common/bloc/dialog_bloc.dart';
import 'package:stohp/src/models/activity.dart';
import 'package:stohp/src/models/distance.dart';
import 'package:stohp/src/models/place.dart';
import 'package:stohp/src/repository/activity_repository.dart';

part 'wake_event.dart';
part 'wake_state.dart';

class WakeBloc extends Bloc<WakeEvent, WakeState> {
  Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Place _selectedPlace;
  StreamSubscription _locationSubscription;
  final ActivityRepository _activityRepository;
  final DialogBloc _dialogBloc;

  WakeBloc(
      {@required ActivityRepository activityRepository, DialogBloc dialogBloc})
      : this._activityRepository = activityRepository,
        this._dialogBloc = dialogBloc;

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }

  @override
  WakeState get initialState => WakeInitial();

  @override
  Stream<WakeState> mapEventToState(
    WakeEvent event,
  ) async* {
    if (event is StartTracking) {
      yield* _mapStartTracking(event.selectedPlace);
    } else if (event is UpdateTracking) {
      yield* _mapUpdateTracking(event.currentPosition);
    } else if (event is CancelTracking) {
      yield* _mapCancelTracking();
    }
  }

  Stream<WakeState> _mapStartTracking(Place selectedPlace) async* {
    _locationSubscription = geolocator
        .getPositionStream()
        .listen((currentPosition) => add(UpdateTracking(currentPosition)));
    _selectedPlace = selectedPlace;
    _activityRepository
        .addActivity(new Activity(name: "Went to ${_selectedPlace.name}."));
  }

  Stream<WakeState> _mapUpdateTracking(Position currentPosition) async* {
    Place userPlace =
        Place(lat: currentPosition.latitude, lng: currentPosition.longitude);
    Distance currentDistance = await _fetchDistance(
        LatLng(currentPosition.latitude, currentPosition.longitude),
        LatLng(_selectedPlace.lat, _selectedPlace.lng));
    List<PointLatLng> polylines =
        PolylinePoints().decodePolyline(currentDistance.points);
    List<LatLng> polylineCoordinates = [];
    polylines.forEach((PointLatLng point) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    });
    if (currentDistance.distanceInValue <= 100) {
      _dialogBloc.add(ShowDialog());
    }
    yield WakeRunning(
        _selectedPlace, userPlace, currentDistance, polylineCoordinates);
  }

  Stream<WakeState> _mapCancelTracking() async* {
    _locationSubscription?.cancel();
    _selectedPlace = null;
    yield WakeInitial();
  }
}

Future<Distance> _fetchDistance(LatLng source, LatLng destination) async {
  http.Client client = http.Client();
  final response = await client.get(
      'https://maps.googleapis.com/maps/api/directions/json?origin=${source.latitude},${source.longitude}&destination=${destination.latitude},${destination.longitude}&key=[GOOGLE_API_KEY]');
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return Distance.fromJson(data);
  } else {
    print("Couldn't parse data");
    return null;
  }
}
