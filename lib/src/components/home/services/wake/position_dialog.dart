import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stohp/src/components/common/option_button.dart';
import 'package:stohp/src/components/home/services/bloc/location_track_bloc.dart';
import 'package:stohp/src/values/values.dart';

class PositionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LocationTrackBloc _bloc = BlocProvider.of<LocationTrackBloc>(context);
    Completer<GoogleMapController> _controller = Completer();
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(14.657671, 121.053602),
      zoom: 14.0,
    );
    final double _usabelScreenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return BlocBuilder<LocationTrackBloc, LocationTrackState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is LocationRunning)
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: Container(
              height: _usabelScreenHeight * .8,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    height: _usabelScreenHeight * .40,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      rotateGesturesEnabled: false,
                      tiltGesturesEnabled: false,
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
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
                            state.location,
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
                                    value: "144",
                                    unit: "km",
                                  ),
                                  StatusInfo(
                                    title: Strings.estimatedTimeOfArrival,
                                    value: "54",
                                    unit: "mins",
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
                                        buildConfirmationAlert(context).show(),
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
            ),
          );
        else
          return Dialog(
            child: CircularProgressIndicator(),
          );
      },
    );
  }

  Alert buildConfirmationAlert(BuildContext context) {
    return Alert(
      context: context,
      type: AlertType.error,
      title: Strings.cancelTripTitle,
      desc: Strings.cancelTripDesc,
      buttons: [
        OptionButton(
          color: redPrimary,
          onPressed: () {
            // Call remove track
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
    );
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
