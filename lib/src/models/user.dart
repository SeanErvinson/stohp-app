import 'package:stohp/src/models/profile.dart';

class User {
  String id;
  String username;
  String email;
  String firstName;
  String lastName;
  bool isDriver;
  bool isCommuter;
  Profile profile;

  User(
      {this.id,
      this.username,
      this.email,
      this.firstName,
      this.lastName,
      this.isDriver,
      this.isCommuter,
      this.profile});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    isDriver = json['is_driver'];
    isCommuter = json['is_commuter'];
    profile = json['profile'] != null
        ? new Profile.fromJson(json['profile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['is_driver'] = this.isDriver;
    data['is_commuter'] = this.isCommuter;
    if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }
    return data;
  }
}