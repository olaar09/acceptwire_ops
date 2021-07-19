part of 'transactions_bloc.dart';

class TransactionState
    extends Union2Impl<_TransactionsInitial, _TransactionsLoaded> {
  // PRIVATE low-level factory
  // Used for instantiating individual "subclasses"
  static final Doublet<_TransactionsInitial, _TransactionsLoaded> _factory =
      const Doublet<_TransactionsInitial, _TransactionsLoaded>();

  // PRIVATE constructor which takes in the individual weather states
  TransactionState._(Union2<_TransactionsInitial, _TransactionsLoaded> union)
      : super(union);

  factory TransactionState.initial() =>
      TransactionState._(_factory.first(_TransactionsInitial()));

  factory TransactionState.loaded(
          {required List<TransactionPODO> transactions}) =>
      TransactionState._(
          _factory.second(_TransactionsLoaded(transactions: transactions)));
}

class _TransactionsInitial extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class _TransactionsLoaded extends Equatable {
  final List<TransactionPODO> transactions;

  _TransactionsLoaded({required this.transactions});

  @override
  // TODO: implement props
  List<Object?> get props => [transactions];
}
