import 'package:acceptwire/podo/login_podo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sealed_unions/sealed_unions.dart';

class AuthenticationState extends Union7Impl<
    _AuthenticationLoading,
    _AuthDataValidationFailed,
    _LoginAttemptFailed,
    _SignUpAttemptFailed,
    _UserUnAuthenticated,
    _UserAuthenticated,
    _SignUpAttemptSucceed> {
  // PRIVATE low-level factory
  // Used for instantiating individual "subclasses"
  static final Septet<
          _AuthenticationLoading,
          _AuthDataValidationFailed,
          _LoginAttemptFailed,
          _SignUpAttemptFailed,
          _UserUnAuthenticated,
          _UserAuthenticated,
          _SignUpAttemptSucceed> _factory =
      const Septet<
          _AuthenticationLoading,
          _AuthDataValidationFailed,
          _LoginAttemptFailed,
          _SignUpAttemptFailed,
          _UserUnAuthenticated,
          _UserAuthenticated,
          _SignUpAttemptSucceed>();

  // PRIVATE constructor which takes in the individual weather states
  AuthenticationState._(
      Union7<
              _AuthenticationLoading,
              _AuthDataValidationFailed,
              _LoginAttemptFailed,
              _SignUpAttemptFailed,
              _UserUnAuthenticated,
              _UserAuthenticated,
              _SignUpAttemptSucceed>
          union)
      : super(union);

  // PUBLIC factories which hide the complexity from outside classes
  factory AuthenticationState.loading() =>
      AuthenticationState._(_factory.first(_AuthenticationLoading()));

  factory AuthenticationState.validationFailed({
    String? emailError,
    String? passwordError,
    String? phoneError,
    String? firstNameError,
    String? genericError,
    String? lastNameError,
    String? bvnError,
  }) =>
      AuthenticationState._(_factory.second(_AuthDataValidationFailed(
          emailError: emailError,
          passwordError: passwordError,
          phoneError: phoneError,
          genericError: genericError,
          firstNameError: firstNameError,
          lastNameError: lastNameError,
          bvnError: bvnError)));

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

  factory AuthenticationState.signUpAttemptSucceed(
          {required AuthData authData}) =>
      AuthenticationState._(
          _factory.seventh(_SignUpAttemptSucceed(authData: authData)));
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

  final String? firstNameError;
  final String? genericError;

  final String? lastNameError;
  final String? bvnError;

  _AuthDataValidationFailed(
      {this.emailError,
      this.genericError,
      this.passwordError,
      this.phoneError,
      this.firstNameError,
      this.lastNameError,
      this.bvnError});

  @override
  // TODO: implement props
  List<Object?> get props => [
        emailError,
        passwordError,
        phoneError,
        firstNameError,
        lastNameError,
        bvnError
      ];
}

class _SignUpAttemptFailed extends Equatable {
  final String message;

  _SignUpAttemptFailed({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class _SignUpAttemptSucceed extends Equatable {
  final AuthData authData;

  _SignUpAttemptSucceed({required this.authData});

  @override
  // TODO: implement props
  List<Object?> get props => [authData];
}
