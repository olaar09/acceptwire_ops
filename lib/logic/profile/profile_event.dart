part of 'profile_bloc.dart';

@immutable
class ProfileEvent
    extends Union3Impl<_NeedNewProfile, _FetchProfile, _NeedVerification> {
  // PRIVATE low-level factory
  // Used for instantiating individual "subclasses"
  static final Triplet<_NeedNewProfile, _FetchProfile, _NeedVerification>
      _factory =
      const Triplet<_NeedNewProfile, _FetchProfile, _NeedVerification>();

  // PRIVATE constructor which takes in the individual weather states
  ProfileEvent._(
      Union3<_NeedNewProfile, _FetchProfile, _NeedVerification> union)
      : super(union);

  factory ProfileEvent.needNewProfile({required String phone}) =>
      ProfileEvent._(_factory.first(_NeedNewProfile(phoneNumber: phone)));

  factory ProfileEvent.fetchProfile() =>
      ProfileEvent._(_factory.second(_FetchProfile()));

  factory ProfileEvent.needVerification() =>
      ProfileEvent._(_factory.third(_NeedVerification()));
}

class _NeedNewProfile {
  String phoneNumber;

  _NeedNewProfile({required this.phoneNumber});
}

class _NeedVerification {}

class _FetchProfile {}
