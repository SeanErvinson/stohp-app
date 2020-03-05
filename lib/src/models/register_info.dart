class RegisterInfo {
  String username;
  String password;
  String firstName;
  String lastName;
  String email;

  RegisterInfo(
      {this.username,
      this.password,
      this.firstName,
      this.lastName,
      this.email});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'username': this.username,
      'password': this.password,
      'last_name': this.lastName,
      'first_name': this.firstName,
      'email': this.email,
      "is_commuter": true,
    };
    return data;
  }
}
