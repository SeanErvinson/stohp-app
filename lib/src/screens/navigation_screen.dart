import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stohp/src/values/values.dart';

class NavigationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(14.657671, 121.053602),
      zoom: 14.0,
    );
    final double _usabelScreenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: _usabelScreenHeight * .70,
                child: GoogleMap(
                  mapType: MapType.hybrid,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Technohub Building H",
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      FlatButton(
                        child: Text(
                          Strings.cancel,
                          style: TextStyle(color: redSecondary),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: (_usabelScreenHeight * .70) - 80,
            left: MediaQuery.of(context).size.width / 2 - 120,
            child: FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 12.0),
              textColor: Colors.white,
              child: Text(
                Strings.stohp,
                style: Theme.of(context).textTheme.button,
              ),
              color: redPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
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
            style: Theme.of(context).textTheme.display3,
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
