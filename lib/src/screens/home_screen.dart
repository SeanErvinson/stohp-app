import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:stohp/src/models/activity.dart';
import 'package:stohp/src/models/article.dart';
import 'package:stohp/src/repository/activity_repository.dart';
import 'package:stohp/src/repository/news_stories_repository.dart';

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
                  onPressed: () {},
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
                    onPressed: () {},
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

class NewsStoriesCard extends StatelessWidget {
  const NewsStoriesCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _usableScreenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    NewsStoriesRepository _newsStoriesRepository = new NewsStoriesRepository();
    return Container(
      height: _usableScreenHeight * .3,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CardHeader(
              title: Strings.newsStoriesHeader,
            ),
            Expanded(
              child: FutureBuilder<List<Article>>(
                future: _newsStoriesRepository.fetchArticles(),
                initialData: [],
                builder: (BuildContext context,
                    AsyncSnapshot<List<Article>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.none &&
                      snapshot.data == null) {
                    return Container();
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data != null ? snapshot.data.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      Article currentArticle = snapshot.data[index];
                      return Container(
                        width: 148.0,
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: bgSecondary,
                          child: Column(
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Image.network(currentArticle.image),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Text(
                                  currentArticle.title,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
    ActivityRepository _activityRepository = new ActivityRepository();
    return Flexible(
      flex: 1,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CardHeader(
                title: Strings.activityHeader,
              ),
              Expanded(
                child: FutureBuilder<List<Activity>>(
                  future: _activityRepository.fetchActivities(),
                  initialData: [],
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Activity>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(height: 1),
                        itemCount:
                            snapshot.data != null ? snapshot.data.length : 0,
                        itemBuilder: (context, index) {
                          Activity currentActivity = snapshot.data[index];
                          return ActivityTile(
                              date: formatDate(
                                  currentActivity.createdOn, [d, '/', mm]),
                              time: formatDate(
                                  currentActivity.createdOn, [h, ":", nn, am]),
                              title: currentActivity.title);
                        },
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 8),
      child: Text(_title, style: cardHeader),
    );
  }
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
            style: Theme.of(context).textTheme.subtitle,
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
