import 'dart:async';

import 'package:acceptwire/repository/auth_repository.dart';
import 'package:acceptwire/repository/firebase_realtime_repository.dart';
import 'package:bloc/bloc.dart';

import 'package:acceptwire/podo/transaction_podo.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:sealed_unions/factories/doublet_factory.dart';
import 'package:sealed_unions/sealed_unions.dart';

part 'transactions_state.dart';

class TransactionBloc extends Cubit<TransactionState> {
  FirebaseDBRepo firebaseDBRepo = FirebaseDBRepo();
  late AuthRepository _authRepository;

  late StreamSubscription fireSubscription;

  TransactionBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(TransactionState.initial());

  Future init() async {
    fireSubscription = firebaseDBRepo
        .getDataRef(
            reference: 'latest_transactions/${await _authRepository.getUID()}')
        .onValue
        .listen((event) {
      print(event.snapshot.value);

      // print(list);
      if (GetUtils.isNullOrBlank(event.snapshot.value) ?? true) {
        this.emit(TransactionState.initial());
      } else {
        Map map = event.snapshot.value;
        List<TransactionPODO> transactions = [];

        map.forEach(
            (k, val) => transactions.add(TransactionPODO.fromJson(val)));
        this.emit(TransactionState.loaded(transactions: []));
      }
    });
  }

  @override
  Future<void> close() {
    // TODO: implement close
    fireSubscription.cancel();
    return super.close();
  }
}
