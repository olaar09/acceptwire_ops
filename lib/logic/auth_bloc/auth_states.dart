import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sealed_unions/sealed_unions.dart';

class AuthenticationState extends Union6Impl<
    _AuthenticationLoading,
    _AuthDataValidationFailed,
    _LoginAttemptFailed,
    _SignUpAttemptFailed,
    _UserUnAuthenticated,
    _UserAuthenticated> {
  // PRIVATE low-level factory
  // Used for instantiating individual "subclasses"
  static final Sextet<
          _AuthenticationLoading,
          _AuthDataValidationFailed,
          _LoginAttemptFailed,
          _SignUpAttemptFailed,
          _UserUnAuthenticated,
          _UserAuthenticated> _factory =
      const Sextet<
          _AuthenticationLoading,
          _AuthDataValidationFailed,
          _LoginAttemptFailed,
          _SignUpAttemptFailed,
          _UserUnAuthenticated,
          _UserAuthenticated>();

  // PRIVATE constructor which takes in the individual weather states
  AuthenticationState._(
      Union6<
              _AuthenticationLoading,
              _AuthDataValidationFailed,
              _LoginAttemptFailed,
              _SignUpAttemptFailed,
              _UserUnAuthenticated,
              _UserAuthenticated>
          union)
      : super(union);

  // PUBLIC factories which hide the complexity from outside classes
  factory AuthenticationState.loading() =>
      AuthenticationState._(_factory.first(_AuthenticationLoading()));

  factory AuthenticationState.validationFailed(
          {String? phoneError,
          String? emailError,
          String? passwordError,
          String? nameError}) =>
      AuthenticationState._(_factory.second(_AuthDataValidationFailed(
          passwordError: passwordError,
          nameError: nameError,
          phoneError: phoneError,
          emailError: emailError)));

  factory AuthenticationState.loginAttemptFailed({required String message}) =>
      AuthenticationState._(
          _factory.third(_LoginAttemptFailed(message: message)));

  factory AuthenticationState.signUpAttemptFailed({required String message}) =>
      AuthenticationState._(
          _factory.fourth(_SignUpAttemptFailed(message: message)));

  factory AuthenticationState.userUnAuthenticated() =>
      AuthenticationState._(_factory.fifth(_UserUnAuthenticated()));

  factory AuthenticationState.userAuthenticated({required User user}) =>
      AuthenticationState._(_factory.sixth(_UserAuthenticated(user: user)));
}

class _AuthenticationLoading extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class _UserAuthenticated extends Equatable {
  final User user;

  _UserAuthenticated({required this.user});

  @override
  // TODO: implement props
  List<Object?> get props => [user];
}

class _UserUnAuthenticated extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class _LoginAttemptFailed extends Equatable {
  final String message;

  _LoginAttemptFailed({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class _AuthDataValidationFailed extends Equatable {
  final String? emailError;
  final String? passwordError;
  final String? phoneError;
  final String? nameError;

  _AuthDataValidationFailed(
      {this.emailError, this.passwordError, this.phoneError, this.nameError});

  @override
  // TODO: implement props
  List<Object?> get props => [emailError, passwordError, phoneError, nameError];
}

class _SignUpAttemptFailed extends Equatable {
  final String message;

  _SignUpAttemptFailed({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
