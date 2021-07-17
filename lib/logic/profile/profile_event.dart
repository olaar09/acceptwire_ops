part of 'profile_bloc.dart';

@immutable
class ProfileEvent extends Union2Impl<_NeedNewProfile, _FetchProfile> {
  // PRIVATE low-level factory
  // Used for instantiating individual "subclasses"
  static final Doublet<_NeedNewProfile, _FetchProfile> _factory =
      const Doublet<_NeedNewProfile, _FetchProfile>();

  // PRIVATE constructor which takes in the individual weather states
  ProfileEvent._(Union2<_NeedNewProfile, _FetchProfile> union) : super(union);

  factory ProfileEvent.needNewProfile({required String phone}) =>
      ProfileEvent._(_factory.first(_NeedNewProfile(phoneNumber: phone)));

  // factory ProfileEvent.attemptIdentityVerification() =>
  //     ProfileEvent._(_factory.second(_AttemptIdentityVerification()));
  //
  // factory ProfileEvent.attemptProfileCreation({required phoneNumber}) =>
  //     ProfileEvent._(
  //         _factory.third(_AttemptProfileCreation(phoneNumber: phoneNumber)));

  factory ProfileEvent.fetchProfile() =>
      ProfileEvent._(_factory.second(_FetchProfile()));
}

class _NeedNewProfile {
  String phoneNumber;

  _NeedNewProfile({required this.phoneNumber});
}

class _AttemptIdentityVerification {}

class _AttemptProfileCreation {
  String phoneNumber;

  _AttemptProfileCreation({required this.phoneNumber});
}

class _FetchProfile {}
