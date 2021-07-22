import 'dart:async';

import 'package:acceptwire/podo/login_podo.dart';
import 'package:acceptwire/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'bloc.dart';

class AuthBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository _authRepository;
  late final StreamSubscription firebaseAuthListener;

  //final ProfileBloc _profileBloc;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthenticationState.userUnAuthenticated()) {
    firebaseAuthListener =
        _authRepository.getAuthInstance().authStateChanges().listen((user) {
      if (user == null) {
        /// this is firing continuously, find out why.
        //  fireLoggedOutEvent();
      }
    });
  }

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationLoading) {
      yield AuthenticationState.loading();
    }

    if (event is LoginAttemptEvent) {
      yield* _mapAppLoginAttemptToState(event: event);
    }
    if (event is SignUpAttemptEvent) {
      yield* _mapAppSignUpAttemptToState(event: event);
    }
    if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    }
    if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppLoginAttemptToState(
      {required LoginAttemptEvent event}) async* {
    bool forceStop = false;
    try {
      yield AuthenticationState.loading();
      yield* _runAuthValidations(event).handleError((error) {
        forceStop = true;
        return;
      });

      if (forceStop) return;

      User? user;

      UserCredential userCredential = await _authRepository
          .signInWithCredentials(
        '${event.authData.email}',
        '${event.authData.password}',
      )
          .timeout(Duration(minutes: 2), onTimeout: () {
        throw Exception('timed out');
      });
      user = userCredential.user;
      yield AuthenticationState.userAuthenticated(user: user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        yield AuthenticationState.loginAttemptFailed(
            message: 'Email or password incorrect');
      } else if (e.code == 'wrong-password') {
        yield AuthenticationState.loginAttemptFailed(
            message: 'Email or password incorrect');
      }
    } catch (e) {
      yield AuthenticationState.loginAttemptFailed(
          message: 'An unknown error happened.  check your internet');
    }
  }

  Stream<AuthenticationState> _mapAppSignUpAttemptToState(
      {required SignUpAttemptEvent event}) async* {
    bool forceStop = false;
    try {
      yield AuthenticationState.loading();

      yield* _runAuthValidations(event).handleError((error) {
        forceStop = true;
        return;
      });

      if (forceStop) return;

      User? user;
      await _authRepository.registerUsingEmailPassword(
        '${event.authData.email}',
        '${event.authData.password}',
      );

      user = await _authRepository.updateDisplayName(
          '${event.authData.firstName} ${event.authData.lastName}');

      yield AuthenticationState.signUpAttemptSucceed(authData: event.authData);
      yield AuthenticationState.userAuthenticated(user: user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        yield AuthenticationState.signUpAttemptFailed(
            message:
                'Password must have at least 8 characters(1 upper letter, 1 number, 1 special character )');
      } else if (e.code == 'email-already-in-use') {
        yield AuthenticationState.signUpAttemptFailed(
            message: 'Email already exist. Sign in instead.');
      }
    } catch (e) {
      print(e.toString());
      yield AuthenticationState.signUpAttemptFailed(
          message: 'An unknown error happened');
    }
  }

  Stream<AuthenticationState> _runAuthValidations(event) async* {
    if (event is SignUpAttemptEvent) {
      if (GetUtils.isNullOrBlank(event.authData.phone)!) {
        yield AuthenticationState.validationFailed(
            genericError: ' Enter your your phone number',
            phoneError: ' Enter your phone number');
        throw FormatException();
      }
    }

    if (event is LoginAttemptEvent || event is SignUpAttemptEvent) {
      if (GetUtils.isNullOrBlank(event.authData.email)! ||
          !GetUtils.isEmail('${event.authData.email}')) {
        yield AuthenticationState.validationFailed(
            genericError: ' Enter a valid  email address',
            emailError: ' Provide a valid email address');
        throw FormatException();
      }

      if (GetUtils.isNullOrBlank(event.authData.password)!) {
        yield AuthenticationState.validationFailed(
            genericError: ' Provide a password',
            passwordError: ' Provide a password');
        throw FormatException();
      }
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    User? user = await _authRepository.getUser();
    if (GetUtils.isNullOrBlank(user) ?? true)
      yield AuthenticationState.userUnAuthenticated();
    else
      yield AuthenticationState.userAuthenticated(user: user!);
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    _authRepository.signOut();
    yield AuthenticationState.userUnAuthenticated();
  }

  loadUser() async {
    User? user = await _authRepository.getUser();
    if (user != null) {
      this.add(LoggedIn());
    } else {
      this.add(LoggedOut());
    }
  }

  fireLoggedOutEvent() {
    this.add(LoggedOut());
  }

  fireLoggedInEvent({required email, required password}) {
    this.add(AuthenticationLoading());
    this.add(LoginAttemptEvent(
        authData: AuthData.login(email: email, password: password)));
  }

  fireRegisterEvent(
      { //required firstName,
      required phone,
      //  required bvn,
      required password,
      required email}) {
    this.add(SignUpAttemptEvent(
        authData: AuthData.signUp(
      email: email,
      password: password,
      phone: phone,
    )));
  }

  @override
  Future<void> close() {
    firebaseAuthListener.cancel();
    return super.close();
  }
}
