import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stohp/src/values/values.dart';

class PositionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(14.657671, 121.053602),
      zoom: 14.0,
    );
    final double _usabelScreenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
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
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
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
                              child: Text(
                                Strings.cancel,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.0),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext builder) {
                                    return AlertDialog(
                                      title: Text("Are you sure?"),
                                    );
                                  },
                                );
                              },
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
                                style: TextStyle(
                                    color: bluePrimary, fontSize: 14.0),
                              ),
                              onPressed: () => Navigator.of(context).pop(),
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
