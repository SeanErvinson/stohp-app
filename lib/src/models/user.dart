import 'package:stohp/src/models/gender.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final Gender gender;

  User(this.id, this.firstName, this.lastName, this.gender, this.email);
}
