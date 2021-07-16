import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'app_config_event.dart';

part 'app_config_state.dart';

class AppConfigBloc extends Bloc<AppConfigEvent, AppConfigState> {
  AppConfigBloc() : super(InitialAppConfigState());

  @override
  Stream<AppConfigState> mapEventToState(AppConfigEvent event) async* {
    // TODO: Add your event logic
  }
}
