import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:stohp/src/components/common/card_header.dart';
import 'package:stohp/src/components/home/activities/activity_tile.dart';
import 'package:stohp/src/models/activity.dart';
import 'package:stohp/src/repository/activity_repository.dart';
import 'package:stohp/src/repository/user_repository.dart';
import 'package:stohp/src/values/values.dart';

class ActivitiesSection extends StatelessWidget {
  const ActivitiesSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserRepository _userRepository = UserRepository();
    ActivityRepository _activityRepository =
        new ActivityRepository(userRepository: _userRepository);
    return Flexible(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(top: 4),
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
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      default:
                        if (snapshot.hasError) return Container();
                        return ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(height: 1),
                          itemCount:
                              snapshot.data != null ? snapshot.data.length : 0,
                          itemBuilder: (context, index) {
                            Activity currentActivity = snapshot.data[index];
                            return ActivityTile(
                                date: formatDate(
                                    currentActivity.createdOn, [M, '. ', dd]),
                                time: formatDate(currentActivity.createdOn,
                                    [h, ":", nn, am]),
                                title: currentActivity.name);
                          },
                        );
                    }
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
