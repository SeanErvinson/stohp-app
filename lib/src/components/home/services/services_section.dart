import 'package:flutter/material.dart';
import 'package:stohp/src/components/common/card_header.dart';
import 'package:stohp/src/values/values.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.white,
        elevation: 1,
        semanticContainer: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CardHeader(
                title: Strings.servicesHeader,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ServiceButton(
                    title: Strings.wakeService,
                    icon: Icons.alarm,
                    onPressed: () {},
                  ),
                  ServiceButton(
                    title: Strings.stopService,
                    icon: Icons.pause,
                    onPressed: () {},
                  ),
                  ServiceButton(
                    title: Strings.mapService,
                    icon: Icons.map,
                    onPressed: () => Navigator.pushNamed(context, "navigation"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceButton extends StatelessWidget {
  final String _title;
  final VoidCallback _onPressed;
  final IconData _icon;

  const ServiceButton(
      {Key key, String title, VoidCallback onPressed, IconData icon})
      : this._title = title,
        this._onPressed = onPressed,
        this._icon = icon,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          child: IconButton(
            icon: Icon(_icon),
            iconSize: 24.0,
            onPressed: _onPressed,
          ),
        ),
        Text(_title)
      ],
    );
  }
}
