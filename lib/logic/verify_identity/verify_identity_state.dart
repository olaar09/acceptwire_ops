part of 'verify_identity_bloc.dart';

class VerifyIdentityState
    extends Union4Impl<_Verifying, _Created, _Error, _Initial> {
  // PRIVATE low-level factory
  // Used for instantiating individual "subclasses"
  static final Quartet<_Verifying, _Created, _Error, _Initial> _factory =
      const Quartet<_Verifying, _Created, _Error, _Initial>();

  // PRIVATE constructor which takes in the individual weather states
  VerifyIdentityState._(
    Union4<_Verifying, _Created, _Error, _Initial> union,
  ) : super(union);

  // PUBLIC factories which hide the complexity from outside classes
  factory VerifyIdentityState.verifying() =>
      VerifyIdentityState._(_factory.first(_Verifying()));

  factory VerifyIdentityState.created() =>
      VerifyIdentityState._(_factory.second(_Created()));

  factory VerifyIdentityState.error(
          {String? firstName,
          String? lastName,
          String? bvn,
          String? genericErr}) =>
      VerifyIdentityState._(_factory.third(_Error(
          firstNameErr: firstName,
          lastNameErr: lastName,
          bvnNameErr: bvn,
          genericErr: genericErr)));

  factory VerifyIdentityState.initial() =>
      VerifyIdentityState._(_factory.fourth(_Initial()));
}

class _Initial extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class _Verifying extends Equatable {
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
  final String? firstNameErr;
  final String? lastNameErr;
  final String? bvnNameErr;
  final String? genericErr;

  _Error(
      {this.firstNameErr = '',
      this.lastNameErr = '',
      this.bvnNameErr = '',
      this.genericErr = ''});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [firstNameErr, lastNameErr, bvnNameErr, genericErr];
}
