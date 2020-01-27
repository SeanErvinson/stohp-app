import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import '../values/values.dart';

class HomeScreen extends StatelessWidget {
  final String name;
  const HomeScreen({Key key, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _usableScreenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgSecondary,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
                    child: GreetingHeader(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.person),
                )
              ],
            ),
            ServicesCard(),
            ActivitiesCard(),
            NewsStoriesCard(),
          ],
        ),
      ),
    );
  }
}

class ServicesCard extends StatelessWidget {
  const ServicesCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      semanticContainer: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CardHeader(
            title: Strings.servicesHeader,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircleAvatar(
                child: IconButton(
                  icon: Icon(Icons.alarm),
                  iconSize: 24.0,
                  onPressed: () {},
                ),
              ),
              IconButton(
                icon: Icon(Icons.stop),
                iconSize: 24.0,
              ),
              IconButton(
                icon: Icon(Icons.map),
                iconSize: 24.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NewsStoriesCard extends StatelessWidget {
  const NewsStoriesCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CardHeader(
              title: Strings.newsStoriesHeader,
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    height: 20,
                    width: 100,
                    child: Text(index.toString()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ActivitiesCard extends StatelessWidget {
  const ActivitiesCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CardHeader(
              title: Strings.activityHeader,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Text(index.toString());
                },
                itemCount: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardHeader extends StatelessWidget {
  final String _title;

  const CardHeader({Key key, String title})
      : this._title = title,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: TextStyle(
        color: logoPrimary,
        fontSize: 16.0,
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
      textAlign: TextAlign.center,
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
