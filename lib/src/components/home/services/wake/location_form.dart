import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:stohp/src/components/home/services/bloc/location_track_bloc.dart';
import 'package:stohp/src/models/place.dart';
import 'package:stohp/src/repository/places_repository.dart';
import 'package:stohp/src/values/values.dart';

import 'bloc/place_bloc.dart';

class LocationForm extends StatefulWidget {
  final PlacesRepository _repository;

  const LocationForm({Key key, PlacesRepository repository})
      : this._repository = repository,
        super(key: key);

  @override
  _LocationFormState createState() => _LocationFormState(_repository);
}

class _LocationFormState extends State<LocationForm> {
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _textFocus = FocusNode();
  final PlacesRepository repository;
  PlaceBloc _bloc;

  _LocationFormState(this.repository);

  @override
  void initState() {
    super.initState();
    _bloc = PlaceBloc(placesRepository: repository);
    _textEditingController.addListener(_onSearchLocationChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceBloc, PlaceState>(
      bloc: _bloc,
      builder: (context, state) {
        Widget placeListView;
        if (state is SearchInitial) {
          placeListView = Container();
        }
        if (state is SearchLoading) {
          placeListView = Center(child: CircularProgressIndicator());
        }
        if (state is SearchLoaded) {
          placeListView = ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                Divider(height: 1),
            itemCount: state.places != null ? state.places.length : 0,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  PlacesSearchResult result = state.places[index];
                  Place selectedPlace = Place(
                      formattedAddress: result.formattedAddress,
                      id: result.id,
                      lat: result.geometry.location.lat,
                      lng: result.geometry.location.lng,
                      name: result.name);
                  BlocProvider.of<LocationTrackBloc>(context)
                      .add(StartTracking(selectedPlace));
                  Navigator.of(context).pop();
                },
                child: SuggestionTile(
                  title: state.places[index].name,
                  subtitle: state.places[index].formattedAddress,
                ),
              );
            },
          );
        }
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _textEditingController,
                  focusNode: _textFocus,
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      icon: Icon(Icons.location_on),
                      hintText: Strings.destinationHint,
                      hintStyle: TextStyle(fontSize: 12)),
                ),
                Expanded(
                  child: placeListView,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onSearchLocationChanged() {
    bool hasFocus = _textFocus.hasFocus;
    if (_textEditingController.text.length <= 0 || !hasFocus) return;
    _bloc.add(OnSearchPlaceChange(location: _textEditingController.text));
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _bloc.close();
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
        ],
      ),
    );
  }
}
