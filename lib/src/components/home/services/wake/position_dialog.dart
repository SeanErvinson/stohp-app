import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stohp/src/components/common/option_button.dart';
import 'package:stohp/src/components/home/services/bloc/wake_bloc.dart';
import 'package:stohp/src/values/values.dart';

class PositionDialog extends StatelessWidget {
  static const double _dialogRadius = 6.0;
  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();
    final double _usabelScreenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    CameraPosition _cameraPosition;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: BlocBuilder<WakeBloc, WakeState>(
        bloc: BlocProvider.of<WakeBloc>(context),
        builder: (context, state) {
          if (state is WakeRunning) {
            _cameraPosition = CameraPosition(
                target: LatLng(state.source.lat, state.source.lng), zoom: 14.0);
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(_dialogRadius)),
              height: _usabelScreenHeight * .8,
              child: Column(
                children: <Widget>[
                  Container(
                    height: _usabelScreenHeight * .40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(_dialogRadius),
                          topRight: Radius.circular(_dialogRadius)),
                      child: GoogleMap(
                        mapType: MapType.normal,
                        minMaxZoomPreference: MinMaxZoomPreference(14.0, 18.0),
                        rotateGesturesEnabled: false,
                        myLocationEnabled: true,
                        tiltGesturesEnabled: false,
                        markers: Set<Marker>()
                          ..add(Marker(
                              markerId: MarkerId('Destination'),
                              position: LatLng(state.destination.lat,
                                  state.destination.lng))),
                        polylines: Set<Polyline>()
                          ..add(Polyline(
                            polylineId: PolylineId("line"),
                            points: state.polylineCoordinates,
                            endCap: Cap.roundCap,
                            startCap: Cap.roundCap,
                            color: bluePrimary,
                          )),
                        initialCameraPosition: _cameraPosition,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            state.destination.name,
                            style: Theme.of(context).textTheme.subhead,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  StatusInfo(
                                      title: Strings.distanceRemaining,
                                      value: state.distance.distanceInText,
                                      unit: state.distance.distanceInUnit),
                                  StatusInfo(
                                    title: Strings.estimatedTimeOfArrival,
                                    value: state.distance.durationInText,
                                    unit: state.distance.durationInUnit,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  width: double.infinity,
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero),
                                    color: redPrimary,
                                    child: Text(Strings.cancel,
                                        style: optionButton),
                                    onPressed: () =>
                                        _onConfirmationAlert(context),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  width: double.infinity,
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.black54),
                                        borderRadius: BorderRadius.zero),
                                    child: Text(
                                      Strings.close,
                                      style: optionButton.copyWith(
                                          color: bluePrimary),
                                    ),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container(
              height: _usabelScreenHeight * .8,
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  _onConfirmationAlert(BuildContext context) {
    final WakeBloc _bloc = BlocProvider.of<WakeBloc>(context);
    Alert(
      context: context,
      type: AlertType.error,
      title: Strings.cancelTripTitle,
      desc: Strings.cancelTripDesc,
      buttons: [
        OptionButton(
          color: redPrimary,
          onPressed: () {
            _bloc.add(CancelTracking());
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          title: Strings.yesOption,
        ),
        OptionButton(
          color: greenPrimary,
          onPressed: () {
            Navigator.of(context).pop();
          },
          title: Strings.noOption,
        ),
      ],
    ).show();
  }
}

class StatusInfo extends StatelessWidget {
  final String title;
  final String value;
  final String unit;

  const StatusInfo({this.title, this.value, this.unit});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: Theme.of(context).textTheme.subhead,
        ),
        RichText(
          text: TextSpan(
            text: value,
            style: Theme.of(context).textTheme.display2,
            children: [
              TextSpan(
                text: unit,
                style: Theme.of(context).textTheme.subhead,
              )
            ],
          ),
        ),
      ],
    );
  }
}
