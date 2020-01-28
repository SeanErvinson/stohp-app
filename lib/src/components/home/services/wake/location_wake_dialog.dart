import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:stohp/src/values/values.dart';

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
