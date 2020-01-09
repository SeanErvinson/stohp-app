import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_webservice/places.dart';

import 'package:qrscan/qrscan.dart' as scanner;
import 'package:qr_flutter/qr_flutter.dart';

import '../values/values.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PlacesSearchResult selected;
  final TextEditingController _searchTextController = TextEditingController();

  Future<List<PlacesSearchResult>> searchPlace(String query) async {
    final places =
        new GoogleMapsPlaces(apiKey: "AIzaSyDjhvBKoej7NWdGR5AOXUNaJLpLr4it5AY");
    PlacesSearchResponse response = await places.searchByText(query);
    return response.results;
  }

  void prettyPrint(List<PlacesSearchResult> results) {
    for (var i = 0; i < results.length; i++) {
      print("${i + 1} - ${results[i].name} :: ${results[i].formattedAddress}");
    }
  }

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
          body: Column(
            children: <Widget>[
              Container(
                height: _usableScreenHeight / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RichText(
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
                    ),
                    Text(
                      Strings.destination,
                      style: Theme.of(context).textTheme.title,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 24.0),
                      width: 240.0,
                      child: TypeAheadField<PlacesSearchResult>(
                        suggestionsBoxDecoration: SuggestionsBoxDecoration(
                            constraints: BoxConstraints(
                          maxHeight: 150.0,
                        )),
                        hideOnEmpty: true,
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: _searchTextController,
                          autofocus: true,
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
                          return ListTile(
                            title: Text(suggestion.name),
                            subtitle: Text(suggestion.formattedAddress),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          print(suggestion.name);
                          _searchTextController.text = suggestion.name;
                        },
                      ),
                    ),
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
              // TODO: Change into Sliver
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(48.0),
                    topRight: Radius.circular(48.0),
                  ),
                  color: Color.fromRGBO(240, 240, 240, 1),
                ),
                padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 48.0),
                height: _usableScreenHeight / 2,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 16.0, left: 4.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Strings.activityHeader,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  Future _scan() async {
    String barcode = await scanner.scan();
  }
}
