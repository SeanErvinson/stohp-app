import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:stohp/src/models/activity.dart';
import 'package:stohp/src/repository/user_repository.dart';
import 'package:stohp/src/services/api_service.dart';

class ActivityRepository {
  final UserRepository _userRepository;

  ActivityRepository({UserRepository userRepository})
      : this._userRepository = userRepository;
  Future<List<Activity>> fetchActivities({limit = 5}) async {
    var token = await _userRepository.getToken();
    String url = "${ApiService.baseUrl}/api/v1/activities/";
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      Iterable results = jsonData["results"];
      var activities =
          results.map((model) => Activity.fromJson(model)).toList();
      return activities;
    }
    return null;
  }

  Future<Activity> fetchActivity(String id) async {
    var token = await _userRepository.getToken();
    String url = "${ApiService.baseUrl}/api/v1/activities/$id";
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return Activity.fromJson(jsonData);
    }
    return null;
  }
}
