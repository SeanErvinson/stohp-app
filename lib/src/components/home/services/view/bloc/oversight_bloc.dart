import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:stohp/src/models/commuter_oversight_info.dart';
import 'package:stohp/src/models/driver_oversight_info.dart';
import 'package:stohp/src/models/oversight_filter.dart';
import 'package:stohp/src/services/api_service.dart';
import 'package:web_socket_channel/io.dart';

part 'oversight_event.dart';
part 'oversight_state.dart';

class OversightBloc extends Bloc<OversightEvent, OversightState> {
  CommuterOversightInfo _commuterOversightInfo;
  Map<MarkerId, Marker> markers = {};

  Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  IOWebSocketChannel _driverCommuterSocket;
  IOWebSocketChannel _commuterDriverSocket;

  StreamSubscription _userLocationSubscription;
  StreamSubscription _driverCommuterSocketSubscription;

  final StreamController<Map<MarkerId, Marker>> _markersController =
      StreamController<Map<MarkerId, Marker>>();

  Stream<Map<MarkerId, Marker>> get outMarkers => _markersController.stream;

  static const String _iconCarSpaceAsset = 'assets/icons/car-full.png';
  static const String _iconCarFullAsset = 'assets/icons/car-space.png';
  Uint8List pinCarSpaceIcon;
  Uint8List pinCarFullIcon;

  OversightBloc(CommuterOversightInfo commuterOversightInfo) {
    _commuterOversightInfo = commuterOversightInfo;
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
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
    } else if (event is UpdateFilter) {
      yield* _mapUpdateFilter(event.filter);
    } else if (event is DisconnectRoom) {
      yield* _mapDisconnectRoom();
    }
  }

  Stream<OversightState> _mapConnectRoom() async* {
    pinCarFullIcon = await getBytesFromAsset(_iconCarFullAsset, 64);
    pinCarSpaceIcon = await getBytesFromAsset(_iconCarSpaceAsset, 64);
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
      _parseDriverData(jsonData);
    });
  }

  void _parseDriverData(Map jsonData) {
    if (jsonData["dc_info"] == null) return;
    var driver = DriverOversightInfo.fromJson(jsonData["dc_info"]);
    if (jsonData["action"] == "disconnect") {
      _removeMarker(driver.id);
      return;
    }
    add(UpdateDriverPosition(driver));
  }

  Stream<OversightState> _mapUpdateFilter(OversightFilter filter) async* {
    if (filter == null) return;
    _commuterOversightInfo.vehicleType = filter.vehicleType;
    _commuterOversightInfo.route = filter.route;
  }

  Stream<OversightState> _mapUpdateDriverPosition(
      DriverOversightInfo driverPosition) async* {
    _createUpdateMarker(driverPosition);
    _markersController.sink.add(markers);
  }

  Stream<OversightState> _mapUpdateCommuterPosition(Position position) async* {
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

  void _sendDisconnectRequest() {
    Map commuterData = {
      "cd_info": {
        "id": _commuterOversightInfo.id,
      },
      "action": "disconnect",
    };
    var jsonData = jsonEncode(commuterData);
    _commuterDriverSocket.sink?.add(jsonData);
  }

  Stream<OversightState> _mapDisconnectRoom() async* {
    _sendDisconnectRequest();
    yield OversightInitial();
  }

  void _createUpdateMarker(DriverOversightInfo driverInfo) {
    final MarkerId _markerId = MarkerId(driverInfo.id.toString());
    if (driverInfo.vehicleType != _commuterOversightInfo.vehicleType &&
        _commuterOversightInfo.vehicleType != null) {
      _removeMarker(driverInfo.id);
      return;
    }
    if (_commuterOversightInfo.route != null &&
        !driverInfo.route
            .toLowerCase()
            .contains(_commuterOversightInfo.route.toLowerCase())) {
      _removeMarker(driverInfo.id);
      return;
    }
    markers.update(_markerId, (marker) {
      return marker.copyWith(
          iconParam: !driverInfo.isFull
              ? BitmapDescriptor.fromBytes(pinCarFullIcon)
              : BitmapDescriptor.fromBytes(pinCarSpaceIcon),
          positionParam: LatLng(driverInfo.lat, driverInfo.lng));
    }, ifAbsent: () {
      return Marker(
          draggable: false,
          markerId: _markerId,
          flat: true,
          position: LatLng(driverInfo.lat, driverInfo.lng),
          infoWindow: InfoWindow(
            title: driverInfo.route,
            snippet: driverInfo.vehicleType,
          ),
          icon: !driverInfo.isFull
              ? BitmapDescriptor.fromBytes(pinCarFullIcon)
              : BitmapDescriptor.fromBytes(pinCarSpaceIcon));
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
    _driverCommuterSocket.sink?.close();
    _userLocationSubscription?.cancel();
    _driverCommuterSocketSubscription?.cancel();
    _markersController?.close();
    _commuterDriverSocket.sink?.close();
  }
}
