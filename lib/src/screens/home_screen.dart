import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import '../values/values.dart';

class HomeScreen extends StatelessWidget {
  // Will be replaced with the user model
  final String name;

  const HomeScreen({Key key, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _usableScreenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var initial = 0.0;
    var distance = 0.0;

    return SafeArea(
      child: GestureDetector(
        onPanStart: (DragStartDetails details) {
          initial = details.globalPosition.dx;
        },
        onPanUpdate: (DragUpdateDetails details) {
          distance = details.globalPosition.dx - initial;
        },
        onPanEnd: (DragEndDetails details) {
          initial = 0.0;
          if (distance < -100) _scan();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: _usableScreenHeight * .45,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GreetingHeader(),
                      Text(
                        Strings.destination,
                        style: Theme.of(context).textTheme.title,
                      ),
                      LocationAutoCompleteTextField(),
                      FlatButton(
                        padding: EdgeInsets.symmetric(
                            horizontal: 80.0, vertical: 12.0),
                        textColor: Colors.white,
                        child: Text(
                          Strings.start,
                          style: Theme.of(context).textTheme.button,
                        ),
                        color: Color.fromRGBO(0, 177, 79, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "navigation");
                        },
                      )
                    ],
                  ),
                ),
              ),
              // TODO: Animation when first sliver is 0
              // Add floating or change icon
              // Change border to zero
              SliverAppBar(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                )),
                primary: true,
                leading: Icon(
                  Icons.directions_run,
                  color: Colors.black,
                ),
                elevation: 0.0,
                pinned: true,
                backgroundColor: bgSecondary,
                title: Text(
                  Strings.activityHeader,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (index.isOdd)
                      return Container(
                        child: Divider(),
                        color: bgSecondary,
                      );
                    final i = index ~/ 2;
                    return ActivityTile(
                      place: i.toString(),
                      time: "10:00pm,",
                      date: "01/02/03",
                    );
                  },
                  childCount: 25 * 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future _scan() async {
  String barcode = await scanner.scan();
}

class GreetingHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Hello ",
        style: Theme.of(context).textTheme.subtitle,
        children: [
          TextSpan(
            text: "Sean",
            style: Theme.of(context).textTheme.subtitle,
          ),
        ],
      ),
    );
  }
}

class LocationAutoCompleteTextField extends StatelessWidget {
  final TextEditingController _searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24.0),
      width: 300.0,
      child: TypeAheadField<PlacesSearchResult>(
        suggestionsBoxDecoration: SuggestionsBoxDecoration(
            constraints: BoxConstraints(
          maxHeight: 150.0,
        )),
        hideOnEmpty: true,
        textFieldConfiguration: TextFieldConfiguration(
          controller: _searchTextController,
          style: Theme.of(context).textTheme.caption,
          maxLines: 1,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: Strings.location,
          ),
        ),
        suggestionsCallback: (pattern) async {
          return searchPlace(pattern);
        },
        itemBuilder: (context, suggestion) {
          return SuggestionTile(
            title: suggestion.name,
            subtitle: suggestion.formattedAddress,
          );
        },
        onSuggestionSelected: (suggestion) {
          print(suggestion.name);
          _searchTextController.text = suggestion.name;
        },
      ),
    );
  }

  Future<List<PlacesSearchResult>> searchPlace(String query) async {
    final places =
        new GoogleMapsPlaces(apiKey: "AIzaSyDjhvBKoej7NWdGR5AOXUNaJLpLr4it5AY");
    PlacesSearchResponse response = await places.searchByText(query);
    return response.results;
  }
}

class ActivityTile extends StatelessWidget {
  final String place;
  final String date;
  final String time;

  const ActivityTile({this.place, this.date, this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      color: bgSecondary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            place,
            style: Theme.of(context).textTheme.subtitle,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(date),
              Text(time),
            ],
          ),
        ],
      ),
    );
  }
}

class SuggestionTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const SuggestionTile({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 10.0),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Divider(),
        ],
      ),
    );
  }
}
