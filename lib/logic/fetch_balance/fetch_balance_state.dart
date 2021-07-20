part of 'fetch_balance_bloc.dart';

class FetchBalanceState extends Union3Impl<_Initial, _Loading, _Loaded> {
  // PRIVATE low-level factory
  // Used for instantiating individual "subclasses"
  static final Triplet<_Initial, _Loading, _Loaded> _factory =
      const Triplet<_Initial, _Loading, _Loaded>();

  // PRIVATE constructor which takes in the individual weather states
  FetchBalanceState._(Union3<_Initial, _Loading, _Loaded> union) : super(union);

  // PUBLIC factories which hide the complexity from outside classes
  factory FetchBalanceState.initial({String? error}) =>
      FetchBalanceState._(_factory.first(_Initial(error: error)));

  factory FetchBalanceState.loading() =>
      FetchBalanceState._(_factory.second(_Loading()));

  factory FetchBalanceState.loaded({required ProfilePODO profilePODO}) =>
      FetchBalanceState._(_factory.third(_Loaded(profilePODO: profilePODO)));
}

class _Initial extends Equatable {
  final String? error;

  _Initial({this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

class _Loading extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class _Loaded extends Equatable {
  final ProfilePODO profilePODO;

  _Loaded({required this.profilePODO});

  @override
  // TODO: implement props
  List<Object?> get props => [profilePODO.mainBalance];
}
