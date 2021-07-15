import 'package:acceptwire/data/podo/login_podo.dart';
import 'package:flutter/material.dart';

abstract class AuthenticationEvent {}

class AuthenticationLoading extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {}

class LoggedOut extends AuthenticationEvent {}

class AuthenticationError extends AuthenticationEvent {
  String? message;

  AuthenticationError({@required this.message});
}

class LoginAttemptFailedEvent extends AuthenticationEvent {}

class LoginAttemptEvent extends AuthenticationEvent {
  AuthData authData;

  LoginAttemptEvent({required this.authData});
}

class SignUpAttemptEvent extends AuthenticationEvent {
  AuthData authData;

  SignUpAttemptEvent({required this.authData});
}

class AuthDataValidationFailedEvent extends AuthenticationEvent {}

class SignUpAttemptFailedEvent extends AuthenticationEvent {}
