import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stohp/src/components/common/bloc/alert_bloc.dart';
import 'package:stohp/src/components/home/greeting_header.dart';
import 'package:stohp/src/components/home/news_stories/news_stories_section.dart';
import 'package:stohp/src/components/home/services/bloc/wake_bloc.dart';
import 'package:stohp/src/components/home/services/services_section.dart';
import 'package:stohp/src/components/home/services/wake/travel_status_bar.dart';
import 'package:stohp/src/models/user.dart';
import 'package:stohp/src/values/values.dart';

class HomeScreen extends StatelessWidget {
  final User _user;
  const HomeScreen({Key key, User user})
      : _user = user,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgSecondary,
        body: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GreetingHeader(user: _user),
                ServicesSection(),
                // ActivitiesSection(),
                NewsStoriesSection(),
              ],
            ),
            BlocBuilder<WakeBloc, WakeState>(
              bloc: BlocProvider.of<WakeBloc>(context),
              builder: (context, state) {
                if (state is WakeRunning) {
                  if (state.distance.distanceInValue < 50) {
                    BlocProvider.of<AlertBloc>(context).add(TriggerAlert());
                  }
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
