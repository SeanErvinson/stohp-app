import 'package:stohp/src/models/user.dart';

class Activity {
  int id;
  User user;
  String name;
  DateTime createdOn;

  Activity({this.id, this.user, this.name, this.createdOn});

  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    name = json['name'];
    createdOn = DateTime.parse(json['created_on']).toLocal();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['name'] = this.name;
    data['created_on'] = this.createdOn;
    return data;
  }
}
