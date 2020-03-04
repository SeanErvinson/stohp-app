class PersonalInfo {
  String id;
  String username;
  String firstName;
  String lastName;
  String gender;
  String email;

  PersonalInfo(
      {this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.gender,
      this.email});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': this.id,
      'username': this.username,
      'last_name': this.lastName,
      'first_name': this.firstName,
      'email': this.email,
      'profile': {'gender': this.gender}
    };
    return data;
  }
}
