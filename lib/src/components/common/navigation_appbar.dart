import 'package:flutter/material.dart';
import 'package:stohp/src/values/values.dart';

class NavigationAppbar extends StatelessWidget {
  final String _title;

  const NavigationAppbar({Key key, String title})
      : _title = title,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
            iconSize: 20,
            color: Colors.black54,
          ),
          Text(
            _title,
            style: navigationDarkTitle,
          ),
        ],
      ),
    );
  }
}
