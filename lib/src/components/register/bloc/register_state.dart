import 'package:meta/meta.dart';

@immutable
class RegisterState {
  final bool isFirstNameValid;
  final bool isLastNameValid;
  final bool isEmailValid;
  final bool isUsernameValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid =>
      isUsernameValid &&
      isPasswordValid &&
      isFirstNameValid &&
      isLastNameValid &&
      isEmailValid;

  RegisterState({
    @required this.isFirstNameValid,
    @required this.isLastNameValid,
    @required this.isEmailValid,
    @required this.isUsernameValid,
    @required this.isPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory RegisterState.empty() {
    return RegisterState(
      isFirstNameValid: true,
      isLastNameValid: true,
      isEmailValid: true,
      isUsernameValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isFirstNameValid: true,
      isLastNameValid: true,
      isEmailValid: true,
      isUsernameValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.failure() {
    return RegisterState(
      isFirstNameValid: true,
      isLastNameValid: true,
      isEmailValid: true,
      isUsernameValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isFirstNameValid: true,
      isLastNameValid: true,
      isEmailValid: true,
      isUsernameValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  RegisterState update({
    bool isUsernameValid,
    bool isPasswordValid,
    bool isEmailValid,
    bool isFirstNameValid,
    bool isLastNameValid,
  }) {
    return copyWith(
      isFirstNameValid: isFirstNameValid,
      isLastNameValid: isLastNameValid,
      isEmailValid: isEmailValid,
      isUsernameValid: isUsernameValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    bool isEmailValid,
    bool isFirstNameValid,
    bool isLastNameValid,
    bool isUsernameValid,
    bool isPasswordValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return RegisterState(
      isFirstNameValid: isFirstNameValid ?? this.isFirstNameValid,
      isLastNameValid: isLastNameValid ?? this.isLastNameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''RegisterState {
      isFirstNameValid: $isFirstNameValid,
      isLastNameValid: $isLastNameValid,
      isEmailValid: $isEmailValid,
      isUsernameValid: $isUsernameValid,
      isPasswordValid: $isPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
