part of 'send_receipt_bloc.dart';

class SendReceiptState extends Union5Impl<_Initial, _Loading, _Loaded,
    _ValidationErr, _NetworkErr> {
  // PRIVATE low-level factory
  // Used for instantiating individual "subclasses"
  static final Quintet<_Initial, _Loading, _Loaded, _ValidationErr, _NetworkErr>
      _factory =
      const Quintet<_Initial, _Loading, _Loaded, _ValidationErr, _NetworkErr>();

  // PRIVATE constructor which takes in the individual weather states
  SendReceiptState._(
      Union5<_Initial, _Loading, _Loaded, _ValidationErr, _NetworkErr> union)
      : super(union);

  // PUBLIC factories which hide the complexity from outside classes
  factory SendReceiptState.initial() =>
      SendReceiptState._(_factory.first(_Initial()));

  factory SendReceiptState.loading() =>
      SendReceiptState._(_factory.second(_Loading()));

  factory SendReceiptState.loaded() =>
      SendReceiptState._(_factory.third(_Loaded()));

  factory SendReceiptState.validationErr({phoneErr, purchaseItemErr}) =>
      SendReceiptState._(_factory.fourth(_ValidationErr(
          phoneErr: phoneErr, purchaseItemErr: purchaseItemErr)));

  factory SendReceiptState.networkErr({required message}) =>
      SendReceiptState._(_factory.fifth(_NetworkErr(message: message)));
}

class _Initial extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class _Loading extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class _ValidationErr extends Equatable {
  final String? phoneErr;
  final String? purchaseItemErr;

  _ValidationErr({this.phoneErr, this.purchaseItemErr});

  @override
  // TODO: implement props
  List<Object?> get props => [phoneErr, purchaseItemErr];
}

class _NetworkErr extends Equatable {
  final String message;

  _NetworkErr({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class _Loaded extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
