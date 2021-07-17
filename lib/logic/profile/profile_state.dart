part of 'profile_bloc.dart';

abstract class BaseProfileState {}

@immutable
class ProfileState extends Union6Impl<
    _ProfileLoading,
    _ProfileNotActivated,
    _ProfileNotVerified,
    _ProfileNotFound,
    _ProfileLoaded,
    _ProfileInitial> implements BaseProfileState {
  // PRIVATE low-level factory
  // Used for instantiating individual "subclasses"
  static final Sextet<
          _ProfileLoading,
          _ProfileNotActivated,
          _ProfileNotVerified,
          _ProfileNotFound,
          _ProfileLoaded,
          _ProfileInitial> _factory =
      const Sextet<_ProfileLoading, _ProfileNotActivated, _ProfileNotVerified,
          _ProfileNotFound, _ProfileLoaded, _ProfileInitial>();

  // PRIVATE constructor which takes in the individual weather states
  ProfileState._(
      Union6<_ProfileLoading, _ProfileNotActivated, _ProfileNotVerified,
              _ProfileNotFound, _ProfileLoaded, _ProfileInitial>
          union)
      : super(union);

  factory ProfileState.loading({bool hasError = false}) =>
      ProfileState._(_factory.first(_ProfileLoading(hasError: hasError)));

  factory ProfileState.notActivated() =>
      ProfileState._(_factory.second(_ProfileNotActivated()));

  factory ProfileState.notVerified() =>
      ProfileState._(_factory.third(_ProfileNotVerified()));

  factory ProfileState.notFound({String? message}) =>
      ProfileState._(_factory.fourth(_ProfileNotFound(message: message)));

  factory ProfileState.loaded({required ProfilePODO profile}) =>
      ProfileState._(_factory.fifth(_ProfileLoaded(profilePODO: profile)));

  factory ProfileState.initial({String? message}) =>
      ProfileState._(_factory.sixth(_ProfileInitial()));
}

class _ProfileLoading extends Equatable {
  final bool hasError;

  _ProfileLoading({required this.hasError});

  @override
  // TODO: implement props
  List<Object?> get props => [hasError];
}

class _ProfileNotActivated {
  _ProfileNotActivated();
}

class _ProfileNotVerified {
  _ProfileNotVerified();
}

class _ProfileNotFound {
  String? message;

  _ProfileNotFound({this.message});
}

class _ProfileLoaded {
  ProfilePODO profilePODO;

  _ProfileLoaded({required this.profilePODO});
}

class _ProfileInitial extends Equatable {
  final String? message;

  _ProfileInitial({this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
