import 'package:acceptwire/podo/app_config_podo.dart';

abstract class MetaDataState {}

class MetaDataLoadingState extends MetaDataState {}

class MetaDataLoadedState extends MetaDataState {
  final AppConfig appConfig;

  MetaDataLoadedState({required this.appConfig});
}

class MetaDataErrorState extends MetaDataState {
  String message;

  MetaDataErrorState({required this.message});
}
