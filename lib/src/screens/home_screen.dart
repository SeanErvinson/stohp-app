import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stohp/src/components/home/news_stories/news_stories_section.dart';
import 'package:stohp/src/components/home/services/bloc/wake_bloc.dart';
import 'package:stohp/src/components/home/services/services_section.dart';
import 'package:stohp/src/components/home/services/wake/travel_status_bar.dart';
import 'package:stohp/src/values/values.dart';

class HomeScreen extends StatelessWidget {
  final String name;
  const HomeScreen({Key key, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgSecondary,
        body: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: GreetingHeader(),
                    ),
                    IconButton(
                      icon: Icon(Icons.person),
                      onPressed: () {},
                    )
                  ],
                ),
                ServicesSection(),
                // ActivitiesSection(),
                NewsStoriesSection(),
              ],
            ),
            BlocBuilder<WakeBloc, WakeState>(
              bloc: BlocProvider.of<WakeBloc>(context),
              builder: (context, state) {
                if (state is WakeRunning) {
                  return Positioned(
                    bottom: 0,
                    child: TravelStatusBar(
                      distance: state.distance,
                    ),
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
      ),
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
