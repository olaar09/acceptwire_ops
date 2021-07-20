import 'dart:async';
import 'package:acceptwire/logic/transactions/transactions_bloc.dart';
import 'package:acceptwire/podo/profile_podo.dart';
import 'package:acceptwire/repository/profile_repository.dart';
import 'package:acceptwire/utils/helpers/rest_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sealed_unions/factories/triplet_factory.dart';
import 'package:sealed_unions/sealed_unions.dart';

part 'fetch_balance_state.dart';

class FetchBalanceBloc extends Cubit<FetchBalanceState> {
  late ProfileRepository _repository;

  FetchBalanceBloc(
      {required ProfileRepository repository,
      required TransactionBloc transactionBloc})
      : _repository = repository,
        super(FetchBalanceState.initial()) {
    transactionBloc.stream.listen((event) {
      event.join(
        (_) => null,
        (transactionLoaded) async => await fetchBalance(),
      );
    });
  }

  Future fetchBalance() async {
    this.emit(FetchBalanceState.loading());

    var response = await _repository.getProfile();
    if (response is ProfilePODO) {
      this.emit(FetchBalanceState.loaded(profilePODO: response));
    } else if (response is RequestResponse) {
      this.emit(FetchBalanceState.initial(error: response.reason));
    } else {
      this.emit(FetchBalanceState.initial(error: 'An unknown error occurred'));
    }
  }
}
