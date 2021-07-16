import 'package:acceptwire/podo/app_config_podo.dart';
import 'package:acceptwire/repository/auth_repository.dart';
import 'package:acceptwire/repository/meta_repository.dart';
import 'package:acceptwire/logic/meta_bloc/metadata_event.dart';
import 'package:acceptwire/logic/meta_bloc/metadata_state.dart';
import 'package:acceptwire/utils/helpers/helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MetaDataBloc extends Bloc<MetaDataEvent, MetaDataState> {
  MetaDataRepo metaDataRepo;
  AuthRepository authRepository;

  MetaDataBloc({required this.metaDataRepo, required this.authRepository})
      : super(MetaDataLoadingState());

  @override
  Stream<MetaDataState> mapEventToState(MetaDataEvent event) async* {
    if (event is MetaDataLoadingEvent) yield* _mapToMetaLoading();
  }

  void fireLoadingEvent() {
    this.add(MetaDataLoadingEvent());
  }

  Stream<MetaDataState> _mapToMetaLoading() async* {
    yield MetaDataLoadingState();
    var metaResponse = await metaDataRepo.fetchMetaData();
    if (metaResponse is AppConfig) {
      yield MetaDataLoadedState(appConfig: metaResponse);
    } else {
      yield MetaDataErrorState(message: '$metaResponse');
    }
  }
}
