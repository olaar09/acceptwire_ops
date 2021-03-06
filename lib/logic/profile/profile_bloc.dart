import 'dart:async';
import 'package:acceptwire/logic/auth_bloc/auth_bloc.dart';
import 'package:acceptwire/logic/auth_bloc/auth_states.dart';
import 'package:acceptwire/logic/create_profile/create_profile_bloc.dart';
import 'package:acceptwire/logic/verify_identity/verify_identity_bloc.dart';
import 'package:acceptwire/podo/profile_podo.dart';
import 'package:acceptwire/repository/profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:sealed_unions/sealed_unions.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepository repository;
  late StreamSubscription authSub;
  late StreamSubscription createProfileSub;
  late StreamSubscription verifyIdentitySub;

  ProfileBloc({required AuthBloc authBloc, required this.repository})
      : super(ProfileState.initial()) {
    authSub = authBloc.stream.listen((AuthenticationState authState) {
      authState.join(
        (_) => null,
        (_) => null,
        (_) => null,
        (_) => null,
        (_) => null,
        (_) => null,
        (signUpSuccess) {
          fireNeedNewProfileEvent(
            phoneNumber: signUpSuccess.authData.phone,
            emailAddress: signUpSuccess.authData.email,
          );
        },
      );
    });
  }

  onVerifyProfileNav(VerifyIdentityBloc verifyIdentityBloc) {
    verifyIdentitySub = verifyIdentityBloc.stream
        .listen((VerifyIdentityState verifyIdentityState) {
      verifyIdentityState.join(
        (_) => {},
        (verified) {
          this.add(ProfileEvent.needActivation());
        },
        (_) => {},
        (_) => {},
      );
    });
  }

  onCreateProfileNav(CreateProfileBloc createProfileBloc) {
    createProfileSub = createProfileBloc.stream
        .listen((CreateProfileState createProfileState) {
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
  Future<ProfilePODO>? fireNeedNewProfileEvent(
      {phoneNumber, required emailAddress}) {
    this.add(ProfileEvent.needNewProfile(
      phone: phoneNumber,
      emailAddress: emailAddress,
    ));
  }

  Stream<ProfileState> autoCreateProfile(phoneNumber, emailAddress) async* {
    yield ProfileState.loading(hasError: false);
    var response = await repository.createProfileAfterSignUp(
      phoneNumber: phoneNumber,
      email: emailAddress,
    );
    if (response is ProfilePODO) {
      yield ProfileState.notVerified();
    } else {
      yield ProfileState.notFound();
    }
  }

  Stream<ProfileState> doFetchProfile() async* {
    yield ProfileState.loading(hasError: false);
    var response = await repository.getProfile();
    if (response is ProfilePODO) {
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
      yield* autoCreateProfile(
        needNewProfile.phoneNumber,
        needNewProfile.emailAddress,
      );
    }, (fetchProfile) async* {
      yield* doFetchProfile();
    }, (needsVerification) async* {
      yield ProfileState.notVerified();
    }, (needActivation) async* {
      yield ProfileState.notActivated();
    });
  }

  @override
  Future<void> close() {
    if (!GetUtils.isNull(createProfileSub)) createProfileSub.cancel();
    if (!GetUtils.isNull(verifyIdentitySub)) verifyIdentitySub.cancel();

    authSub.cancel();
    return super.close();
  }
}
