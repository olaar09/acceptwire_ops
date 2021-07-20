import 'dart:async';

import 'package:acceptwire/repository/auth_repository.dart';
import 'package:acceptwire/repository/firebase_realtime_repository.dart';
import 'package:acceptwire/utils/helpers/helpers.dart';
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

  static const RECORD_LIMIT = 20; //20;

  // use this to check if data has already been added for the first time
  bool isDataInitialized = false;

  TransactionBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(TransactionState.initial());

  Future fetchInitial() async {
    firebaseDBRepo
        .getDataRef(
        reference: 'latest_transactions/${await _authRepository.getUID()}')
        .limitToLast(RECORD_LIMIT)
        .once()
        .then((snapshot) {
      if (GetUtils.isNullOrBlank(snapshot.value) ?? true) {
        this.emit(TransactionState.initial());
      } else {
        Map map = snapshot.value;
        List<TransactionPODO> transactions = [];

        map.forEach(
                (k, val) => transactions.add(TransactionPODO.fromJson(val)));
        this.emit(TransactionState.loaded(
            transactions: transactions.reversed.toList()));
        new Future.delayed(const Duration(milliseconds: 10), () {
          isDataInitialized = true;
        });
      }
    });
  }

  Future init() async {
    fireSubscription = firebaseDBRepo
        .getDataRef(
        reference: 'latest_transactions/${await _authRepository.getUID()}')
        .onChildAdded
        .listen((event) {
      print(isDataInitialized);
      if (isDataInitialized) {
        this.state.join((initial) => null, (loaded) {
          print('new data');
          // get new data
          Map map = event.snapshot.value;
          // mark new transaction as appended
          map.putIfAbsent('appended', () => true);

          // get current list
          List<TransactionPODO> currentTransactions = [...loaded.transactions];

          //add new data to beginning of current list
          currentTransactions.insert(0, TransactionPODO.fromJson(map));
          this.emit(TransactionState.loaded(transactions: currentTransactions));

          /// play alert sound
          playTune();
        });
      }
    });
    await fetchInitial();
  }

  @override
  Future<void> close() {
    // TODO: implement close
    fireSubscription.cancel();
    return super.close();
  }
}
