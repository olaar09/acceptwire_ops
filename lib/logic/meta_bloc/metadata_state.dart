import 'package:acceptwire/podo/app_config_podo.dart';
import 'package:equatable/equatable.dart';
import 'package:sealed_unions/sealed_unions.dart';

class MetaDataState extends Union3Impl<_MetaDataLoadingState,
    _MetaDataLoadedState, _MetaDataErrorState> {
  // PRIVATE low-level factory
  // Used for instantiating individual "subclasses"
  static final Triplet<_MetaDataLoadingState, _MetaDataLoadedState,
          _MetaDataErrorState> _factory =
      const Triplet<_MetaDataLoadingState, _MetaDataLoadedState,
          _MetaDataErrorState>();

  // PRIVATE constructor which takes in the individual weather states
  MetaDataState._(
    Union3<_MetaDataLoadingState, _MetaDataLoadedState, _MetaDataErrorState>
        union,
  ) : super(union);

  // PUBLIC factories which hide the complexity from outside classes
  factory MetaDataState.loading() =>
      MetaDataState._(_factory.first(_MetaDataLoadingState()));

  factory MetaDataState.loaded({required AppConfig appConfig}) =>
      MetaDataState._(
          _factory.second(_MetaDataLoadedState(appConfig: appConfig)));

  factory MetaDataState.error({required String message}) =>
      MetaDataState._(_factory.third(_MetaDataErrorState(message: message)));
}

class _MetaDataLoadingState {}

class _MetaDataLoadedState {
  final AppConfig appConfig;

  _MetaDataLoadedState({required this.appConfig});
}

class _MetaDataErrorState {
  final String message;

  _MetaDataErrorState({required this.message});
}
