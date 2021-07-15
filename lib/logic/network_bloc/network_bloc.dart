import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class NetworkState {}

class NetworkInitial extends NetworkState {}

class NetworkConnected extends NetworkState {
  final ConnectivityResult connectivityResult;

  NetworkConnected({required this.connectivityResult});
}

class NetworkDisconnected extends NetworkState {}

class NetworkBloc extends Bloc<ConnectivityResult, NetworkState> {
  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  final Connectivity connectivity;

  NetworkBloc({required this.connectivity}) : super(NetworkInitial()) {
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((event) {
      this.add(event);
    });
  }

  @override
  Future<void> close() {
    // TODO: implement close
    connectivitySubscription.cancel();
    return super.close();
  }

  @override
  Stream<NetworkState> mapEventToState(ConnectivityResult event) async* {
    if (event == ConnectivityResult.none) {
      yield NetworkDisconnected();
    } else {
      yield NetworkConnected(connectivityResult: event);
    }
  }
}
