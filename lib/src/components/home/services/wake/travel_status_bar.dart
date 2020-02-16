import 'package:flutter/material.dart';
import 'package:stohp/src/components/home/services/wake/position_dialog.dart';
import 'package:stohp/src/models/distance.dart';
import 'package:stohp/src/values/values.dart';

class TravelStatusBar extends StatelessWidget {
  final Distance _distance;
  const TravelStatusBar({Key key, @required Distance distance})
      : _distance = distance,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => PositionDialog(),
        );
      },
      child: Container(
        color: greenPrimary,
        width: MediaQuery.of(context).size.width,
        height: 40.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  text: "Distance left ",
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                  children: [
                    TextSpan(
                      text: _distance.distanceInText,
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                    TextSpan(
                      text: _distance.distanceInUnit,
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    )
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: "ETA ",
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                  children: [
                    TextSpan(
                      text: _distance.durationInText,
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                    TextSpan(
                      text: _distance.durationInUnit,
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
