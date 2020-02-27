class Validators {
  static final RegExp _usernameRegExp = RegExp(
    r'^[a-zA-Z0-9]+([_ -]?[a-zA-Z0-9])*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidUsername(String email) {
    return _usernameRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}