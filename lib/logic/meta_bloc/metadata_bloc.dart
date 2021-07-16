import 'package:acceptwire/podo/app_config_podo.dart';
import 'package:acceptwire/repository/auth_repository.dart';
import 'package:acceptwire/repository/meta_repository.dart';
import 'package:acceptwire/logic/meta_bloc/metadata_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MetaDataBloc extends Cubit<MetaDataState> {
  MetaDataRepo metaDataRepo;
  AuthRepository authRepository;

  MetaDataBloc({required this.metaDataRepo, required this.authRepository})
      : super(MetaDataState.loading());

  void fireLoadingEvent() async {
    this.emit(MetaDataState.loading());
    var metaResponse = await metaDataRepo.fetchMetaData();
    if (metaResponse is AppConfig) {
      this.emit(MetaDataState.loaded(appConfig: metaResponse));
    } else {
      this.emit(MetaDataState.error(message: '$metaResponse'));
    }
  }
}
