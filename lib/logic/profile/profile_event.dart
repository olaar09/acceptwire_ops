part of 'profile_bloc.dart';

@immutable
class ProfileEvent extends Union4Impl<_NeedNewProfile, _FetchProfile,
    _NeedVerification, _NeedActivation> {
  // PRIVATE low-level factory
  // Used for instantiating individual "subclasses"
  static final Quartet<_NeedNewProfile, _FetchProfile, _NeedVerification,
          _NeedActivation> _factory =
      const Quartet<_NeedNewProfile, _FetchProfile, _NeedVerification,
          _NeedActivation>();

  // PRIVATE constructor which takes in the individual weather states
  ProfileEvent._(
      Union4<_NeedNewProfile, _FetchProfile, _NeedVerification, _NeedActivation>
          union)
      : super(union);

  factory ProfileEvent.needNewProfile({required String phone}) =>
      ProfileEvent._(_factory.first(_NeedNewProfile(phoneNumber: phone)));

  factory ProfileEvent.fetchProfile() =>
      ProfileEvent._(_factory.second(_FetchProfile()));

  factory ProfileEvent.needVerification() =>
      ProfileEvent._(_factory.third(_NeedVerification()));

  factory ProfileEvent.needActivation() =>
      ProfileEvent._(_factory.fourth(_NeedActivation()));
}

class _NeedNewProfile {
  String phoneNumber;

  _NeedNewProfile({required this.phoneNumber});
}

class _NeedVerification {}

class _NeedActivation {}

class _FetchProfile {}
