import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'bloc/oversight_bloc.dart';

class OversightMap extends StatefulWidget {
  final OversightBloc _bloc;

  const OversightMap({Key key, OversightBloc bloc})
      : this._bloc = bloc,
        super(key: key);
  @override
  _OversightMapState createState() => _OversightMapState(_bloc);
}

class _OversightMapState extends State<OversightMap>
    with WidgetsBindingObserver {
  final OversightBloc bloc;
  Completer<GoogleMapController> _mapController = Completer();

  _OversightMapState(this.bloc);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OversightBloc, OversightState>(
      bloc: bloc,
      builder: (context, state) {
        return StreamBuilder(
          stream: bloc.outMarkers,
          builder: (context, snapshot) {
            CameraPosition cameraPosition = _setInitialCamera(LatLng(12, 104));
            if (state is OversightUpdate) {
              cameraPosition = _setInitialCamera(LatLng(
                  state.currentPosition.latitude,
                  state.currentPosition.longitude));
              _moveToLocation(state.currentPosition.latitude,
                  state.currentPosition.longitude);
            }
            return GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              markers: Set<Marker>.of(
                  snapshot.data != null && snapshot.data.length > 0
                      ? snapshot.data.values
                      : []),
              initialCameraPosition: cameraPosition,
              onMapCreated: _onMapCreated,
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    bloc.add(ConnectRoom());
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    bloc.close();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.detached) {}
  }

  void _onMapCreated(GoogleMapController controller) {
    if (!_mapController.isCompleted) {
      _mapController.complete(controller);
    }
  }

  CameraPosition _setInitialCamera(LatLng latLng) {
    return CameraPosition(target: latLng, zoom: 14.5, tilt: 0);
  }

  Future<void> _moveToLocation(latitude, longitude) async {
    GoogleMapController controller = await _mapController.future;
    CameraPosition _newPos = CameraPosition(
        target: LatLng(latitude, longitude), zoom: 19, bearing: 0);

    controller.animateCamera(CameraUpdate.newCameraPosition(_newPos));
  }
}
