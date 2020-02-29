import 'package:flutter/material.dart';
import 'package:stohp/src/components/home/services/wake/location_form.dart';
import 'package:stohp/src/repository/places_repository.dart';
import 'package:stohp/src/values/values.dart';

class LocationDestinationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: AppBar(
            titleSpacing: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
              color: Colors.black87,
            ),
            title: Text(
              Strings.destination,
              style: TextStyle(color: Colors.black87, fontSize: 14),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            LocationForm(
              repository: PlacesRepository(),
            ),
          ],
        ),
      ),
    );
  }
}
