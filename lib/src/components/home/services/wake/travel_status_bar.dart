import 'package:flutter/material.dart';
import 'package:stohp/src/components/home/services/wake/position_dialog.dart';
import 'package:stohp/src/values/values.dart';

class TravelStatusBar extends StatelessWidget {
  const TravelStatusBar({
    Key key,
  }) : super(key: key);

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
                      text: "32",
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                    TextSpan(
                      text: "km",
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
                      text: "12",
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                    TextSpan(
                      text: "mins",
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
