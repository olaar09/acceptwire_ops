import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState extends Equatable {}

class AuthenticationLoadingState extends AuthenticationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserAuthenticated extends AuthenticationState {
  final User user;

  UserAuthenticated({required this.user});

  @override
  // TODO: implement props
  List<Object?> get props => [user];
}

class UserUnAuthenticated extends AuthenticationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginAttemptFailedState extends AuthenticationState {
  final String message;

  LoginAttemptFailedState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class AuthDataValidationFailedState extends AuthenticationState {
  final String? emailError;
  final String? passwordError;
  final String? phoneError;
  final String? nameError;

  AuthDataValidationFailedState(
      {this.emailError, this.passwordError, this.phoneError, this.nameError});

  @override
  // TODO: implement props
  List<Object?> get props => [emailError, passwordError, phoneError, nameError];
}

class SignUpAttemptFailedState extends AuthenticationState {
  final String message;

  SignUpAttemptFailedState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
