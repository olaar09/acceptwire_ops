import 'package:acceptwire/podo/app_config_podo.dart';
import 'package:acceptwire/repository/auth_repository.dart';
import 'package:acceptwire/repository/meta_repository.dart';
import 'package:acceptwire/logic/meta_bloc/metadata_event.dart';
import 'package:acceptwire/logic/meta_bloc/metadata_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MetaDataBloc extends Cubit<MetaDataState> {
  MetaDataRepo metaDataRepo;
  AuthRepository authRepository;

  MetaDataBloc({required this.metaDataRepo, required this.authRepository})
      : super(MetaDataLoadingState());

  void fireLoadingEvent() async {
    this.emit(MetaDataLoadingState());
    var metaResponse = await metaDataRepo.fetchMetaData();
    if (metaResponse is AppConfig) {
      this.emit(MetaDataLoadedState(appConfig: metaResponse));
    } else {
      this.emit(MetaDataErrorState(message: '$metaResponse'));
    }
  }
}
