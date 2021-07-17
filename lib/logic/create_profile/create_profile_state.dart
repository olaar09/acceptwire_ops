part of 'create_profile_bloc.dart';

class CreateProfileState
    extends Union4Impl<_Creating, _Created, _Error, _Initial> {
  // PRIVATE low-level factory
  // Used for instantiating individual "subclasses"
  static final Quartet<_Creating, _Created, _Error, _Initial> _factory =
      const Quartet<_Creating, _Created, _Error, _Initial>();

  // PRIVATE constructor which takes in the individual weather states
  CreateProfileState._(
    Union4<_Creating, _Created, _Error, _Initial> union,
  ) : super(union);

  // PUBLIC factories which hide the complexity from outside classes
  factory CreateProfileState.creating() =>
      CreateProfileState._(_factory.first(_Creating()));

  factory CreateProfileState.created() =>
      CreateProfileState._(_factory.second(_Created()));

  factory CreateProfileState.error({required String message}) =>
      CreateProfileState._(_factory.third(_Error(message: message)));

  factory CreateProfileState.initial() =>
      CreateProfileState._(_factory.fourth(_Initial()));
}

class _Initial extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class _Creating extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class _Created extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class _Error extends Equatable {
  final String message;

  _Error({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
