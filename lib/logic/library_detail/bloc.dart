import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class LibraryDetailBloc extends Bloc<library_detailEvent, library_detailState> {
  LibraryDetailBloc() : super(library_detailState().init());

  @override
  Stream<library_detailState> mapEventToState(library_detailEvent event) async* {
    if (event is InitEvent) {
      yield await init();
    }
  }

  Future<library_detailState> init() async {
    return state.clone();
  }
}
