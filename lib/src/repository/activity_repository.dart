import 'package:stohp/src/models/activity.dart';

class ActivityRepository {
  List<Activity> dummyActivities = [
    Activity(
        createdOn: DateTime.now(), id: "1", title: "Technohub", userId: "1"),
    Activity(createdOn: DateTime.now(), id: "2", title: "UST", userId: "1"),
    Activity(
        createdOn: DateTime.now(), id: "3", title: "La Salle", userId: "1"),
    Activity(
        createdOn: DateTime.now(),
        id: "4",
        title: "1622 Sisa Street Sampaloc",
        userId: "1"),
    Activity(
        createdOn: DateTime.now(),
        id: "5",
        title: "432 Dapitan Street Manila",
        userId: "1")
  ];
  Future<List<Activity>> fetchActivities({limit = 5}) async {
    return dummyActivities;
  }

  Future<Activity> fetchActivity(String id) async {
    for (var activity in dummyActivities) {
      if (activity.id == id) return activity;
    }
    return null;
  }
}
