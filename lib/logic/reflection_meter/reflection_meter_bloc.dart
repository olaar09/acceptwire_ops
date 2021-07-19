import 'dart:async';

import 'package:acceptwire/podo/reflection_meter_podo.dart';
import 'package:acceptwire/repository/firebase_realtime_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sealed_unions/sealed_unions.dart';

part 'reflection_meter_state.dart';

class ReflectionMeterBloc extends Cubit<ReflectionMeterState> {
  FirebaseDBRepo firebaseDBRepo = FirebaseDBRepo();
  late StreamSubscription fireSubscription;

  ReflectionMeterBloc() : super(ReflectionMeterState.loaded()) {
    fireSubscription = firebaseDBRepo
        .getDataRef(reference: 'bank_monitors')
        .onValue
        .listen((event) {
      ReflectionMeter meter = ReflectionMeter.fromJson(event.snapshot.value);
      this.emit(ReflectionMeterState.loaded(
          reading: meter.reading, status: meter.status));
    });
  }

  @override
  Future<void> close() {
    // TODO: implement close
    fireSubscription.cancel();
    return super.close();
  }
}
