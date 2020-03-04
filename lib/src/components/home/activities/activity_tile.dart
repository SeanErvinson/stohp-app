import 'package:flutter/material.dart';
import 'package:stohp/src/values/values.dart';

class ActivityTile extends StatelessWidget {
  final String title;
  final String date;
  final String time;

  const ActivityTile({this.title, this.date, this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: primaryBaseText.copyWith(
              fontSize: 12.0,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                time,
                style: activityInfo,
              ),
              Text(
                date,
                style: activityInfo,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
