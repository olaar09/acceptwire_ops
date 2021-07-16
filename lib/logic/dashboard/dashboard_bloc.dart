import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(InitialDashboardState());

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    // TODO: Add your event logic
  }
}
