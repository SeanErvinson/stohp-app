import 'package:enum_to_string/enum_to_string.dart';
import 'package:stohp/src/models/gender.dart';

class Article {
  String id;
  String firstName;
  String lastName;
  String email;
  Gender gender;

  Article({this.id, this.firstName, this.lastName, this.email, this.gender});

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    gender = EnumToString.fromString(Gender.values, json["gender"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['gender'] = EnumToString.parse(this.gender);
    return data;
  }
}
