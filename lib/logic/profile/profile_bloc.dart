import 'dart:async';
import 'package:acceptwire/logic/auth_bloc/auth_bloc.dart';
import 'package:acceptwire/logic/auth_bloc/auth_states.dart';
import 'package:acceptwire/logic/create_profile/create_profile_bloc.dart';
import 'package:acceptwire/podo/profile_podo.dart';
import 'package:acceptwire/repository/profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sealed_unions/sealed_unions.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepository repository;

  ProfileBloc({required AuthBloc authBloc, required this.repository})
      : super(ProfileState.initial()) {
    authBloc.stream.listen((AuthenticationState authState) {
      authState.join(
        (_) => null,
        (_) => null,
        (_) => null,
        (_) => null,
        (_) => null,
        (_) => null,
        (signUpSuccess) {
          print(signUpSuccess.authData.phone);
          fireNeedNewProfileEvent(phoneNumber: signUpSuccess.authData.phone);
        },
      );
    });
  }

  onCreateProfileNav(CreateProfileBloc createProfileBloc) {
    createProfileBloc.stream.listen((CreateProfileState createProfileState) {
      createProfileState.join(
        (_) => {},
        (created) {
          this.add(ProfileEvent.needVerification());
        },
        (_) => {},
        (_) => {},
      );
    });
  }

  verificationRequired() {}

  /// create a new profile after signup
  void fireLoadProfile() {
    this.add(ProfileEvent.fetchProfile());
  }

  /// create a new profile after signup
  Future<ProfilePODO>? fireNeedNewProfileEvent({phoneNumber}) {
    this.add(ProfileEvent.needNewProfile(phone: phoneNumber));
  }

  Stream<ProfileState> autoCreateProfile(phoneNumber) async* {
    yield ProfileState.loading(hasError: false);
    var response =
        await repository.createProfileAfterSignUp(phoneNumber: phoneNumber);
    if (response is ProfilePODO) {
      print(response.firstName);
      yield ProfileState.notVerified();
    } else {
      yield ProfileState.notFound();
    }
  }

  Stream<ProfileState> doFetchProfile() async* {
    yield ProfileState.loading(hasError: false);

    var response = await repository.getProfile();
    if (response is ProfilePODO) {
      print(response.firstName);
      if (!response.verified) {
        yield ProfileState.notVerified();
      } else if (!response.activated) {
        yield ProfileState.notActivated();
      } else {
        yield ProfileState.loaded(profile: response);
      }
    } else {
      if (response == 'Error No user found') {
        yield ProfileState.notFound(message: 'try again');
      } else {
        yield ProfileState.loading(hasError: true);
      }
    }
  }

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    yield* event.join((needNewProfile) async* {
      yield* autoCreateProfile(needNewProfile.phoneNumber);
    }, (fetchProfile) async* {
      yield* doFetchProfile();
    }, (needsVerification) async* {
      yield ProfileState.notVerified();
    });
  }
}
