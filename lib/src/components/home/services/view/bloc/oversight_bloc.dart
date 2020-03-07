import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:stohp/src/models/commuter_oversight_info.dart';
import 'package:stohp/src/models/driver_oversight_info.dart';
import 'package:stohp/src/services/api_service.dart';
import 'package:web_socket_channel/io.dart';

part 'oversight_event.dart';
part 'oversight_state.dart';

class OversightBloc extends Bloc<OversightEvent, OversightState> {
  Map<MarkerId, Marker> markers = {};
  Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  IOWebSocketChannel _driverCommuterSocket;
  IOWebSocketChannel _commuterDriverSocket;

  StreamSubscription _userLocationSubscription;

  StreamSubscription _driverCommuterSocketSubscription;
  StreamSubscription _commuterDriverSocketSubscription;

  final StreamController<Map<MarkerId, Marker>> _markersController =
      StreamController<Map<MarkerId, Marker>>();

  Stream<Map<MarkerId, Marker>> get outMarkers => _markersController.stream;

  static const String _iconCarEmptyAsset = 'assets/icons/car-full.png';
  static const String _iconCarFullAsset = 'assets/icons/car-space.png';
  BitmapDescriptor pinCarEmptyIcon;
  BitmapDescriptor pinCarFullIcon;

  OversightBloc(DriverOversightInfo driverOversightInfo) {
    if (pinCarEmptyIcon == null) {
      BitmapDescriptor.fromAssetImage(
              ImageConfiguration(devicePixelRatio: 2.5), _iconCarEmptyAsset)
          .then((onValue) {
        pinCarEmptyIcon = onValue;
      });
    }
    if (pinCarFullIcon == null) {
      BitmapDescriptor.fromAssetImage(
              ImageConfiguration(devicePixelRatio: 2.5), _iconCarFullAsset)
          .then((onValue) {
        pinCarFullIcon = onValue;
      });
    }
  }

  @override
  OversightState get initialState => OversightInitial();

  @override
  Stream<OversightState> mapEventToState(
    OversightEvent event,
  ) async* {
    if (event is ConnectRoom) {
      yield* _mapConnectRoom();
    } else if (event is UpdateDriverPosition) {
      yield* _mapUpdateDriverPosition(event.driverInfo);
    } else if (event is UpdateCommuterPosition) {
      yield* _mapUpdateCommuterPosition(event.position);
    } else if (event is DisconnectRoom) {
      yield* _mapDisconnectRoom();
    }
  }

  Stream<OversightState> _mapConnectRoom() async* {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    yield OversightUpdate(position);
    _commuterDriverSocket =
        IOWebSocketChannel.connect('${ApiService.baseWsUrl}/ws/cd_beta/');
    _driverCommuterSocket =
        IOWebSocketChannel.connect('${ApiService.baseWsUrl}/ws/dc_beta/');
    _userLocationSubscription =
        geolocator.getPositionStream().listen((currentPosition) {
      add(UpdateCommuterPosition(currentPosition));
    });
    _driverCommuterSocketSubscription =
        _driverCommuterSocket.stream.listen((value) {
      Map jsonData = jsonDecode(value);
      var commuter = DriverOversightInfo.fromJson(jsonData["dc_info"]);
      if (jsonData["action"] == "disconnect")
        _removeMarker(commuter.id);
      else
        add(UpdateDriverPosition(commuter));
    });
  }

  Stream<OversightState> _mapUpdateDriverPosition(
      DriverOversightInfo driverPosition) async* {
    _createUpdateMarker(driverPosition);
    _markersController.sink.add(markers);
  }

  Stream<OversightState> _mapUpdateCommuterPosition(Position position) async* {
    CommuterOversightInfo _commuterOversightInfo = CommuterOversightInfo();
    _commuterOversightInfo.lat = position.latitude;
    _commuterOversightInfo.lng = position.longitude;
    Map commuterData = {
      "cd_info": _commuterOversightInfo.toJson(),
      "action": null,
    };
    var jsonData = jsonEncode(commuterData);
    _commuterDriverSocket.sink.add(jsonData);
    yield OversightUpdate(position);
  }

  Stream<OversightState> _mapDisconnectRoom() async* {
    // Send disconnect
    _closeSockets();
    yield OversightInitial();
  }

  void _createUpdateMarker(DriverOversightInfo driverInfo) {
    final MarkerId _markerId = MarkerId(driverInfo.id.toString());
    markers.update(_markerId, (marker) {
      return marker.copyWith(
          positionParam: LatLng(driverInfo.lat, driverInfo.lng));
    }, ifAbsent: () {
      return Marker(
        draggable: false,
        markerId: _markerId,
        position: LatLng(driverInfo.lat, driverInfo.lng),
        infoWindow: InfoWindow(
          title: driverInfo.route,
        ),
        icon: driverInfo.isFull ? pinCarFullIcon : pinCarEmptyIcon,
      );
    });
  }

  void _removeMarker(String id) {
    final MarkerId _markerId = MarkerId(id);
    markers.remove(_markerId);
    _markersController.sink.add(markers);
  }

  @override
  Future<void> close() {
    _closeSockets();
    return super.close();
  }

  void _closeSockets() {
    _driverCommuterSocket.sink.close();
    _commuterDriverSocket.sink.close();
    _userLocationSubscription?.cancel();
    _driverCommuterSocketSubscription?.cancel();
    _commuterDriverSocketSubscription?.cancel();
    _markersController.close();
  }
}
