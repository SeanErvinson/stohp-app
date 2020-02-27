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
    id = json["user"]['id'];
    username = json["user"]['username'];
    email = json["user"]['email'];
    firstName = json["user"]['first_name'];
    lastName = json["user"]['last_name'];
    isDriver = json["user"]['is_driver'];
    isCommuter = json["user"]['is_commuter'];
    profile = json["user"]['profile'] != null
        ? new Profile.fromJson(json["user"]['profile'])
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