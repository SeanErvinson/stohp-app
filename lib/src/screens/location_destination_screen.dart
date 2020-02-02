import 'package:flutter/material.dart';
import 'package:stohp/src/components/common/navigation_appbar.dart';
import 'package:stohp/src/components/home/services/wake/location_form.dart';
import 'package:stohp/src/repository/places_repository.dart';
import 'package:stohp/src/values/values.dart';

class LocationDestinationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            NavigationAppbar(
              title: Strings.destination,
            ),
            LocationForm(
              repository: PlacesRepository(),
            ),
          ],
        ),
      ),
    );
  }
}
