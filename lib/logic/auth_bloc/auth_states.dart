import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class UserAuthenticated extends AuthenticationState {
  User? user;

  UserAuthenticated({required this.user});
}

class UserUnAuthenticated extends AuthenticationState {}

class LoginAttemptFailedState extends AuthenticationState {
  String message;

  LoginAttemptFailedState({required this.message});
}

class AuthDataValidationFailedState extends AuthenticationState {
  String? emailError;
  String? passwordError;
  String? phoneError;
  String? nameError;

  AuthDataValidationFailedState(
      {this.emailError, this.passwordError, this.phoneError, this.nameError});
}

class SignUpAttemptFailedState extends AuthenticationState {
  String message;

  SignUpAttemptFailedState({required this.message});
}
