part of 'reflection_meter_bloc.dart';

class ReflectionMeterState extends Union1Impl<_MeterLoaded> {
  // PRIVATE low-level factory
  // Used for instantiating individual "subclasses"
  static final Singlet<_MeterLoaded> _factory = const Singlet<_MeterLoaded>();

  // PRIVATE constructor which takes in the individual weather states
  ReflectionMeterState._(Union1<_MeterLoaded> union) : super(union);

  factory ReflectionMeterState.loaded(
          {String reading = 'Loading meters', status: 'ok'}) =>
      ReflectionMeterState._(
          _factory.first(_MeterLoaded(reading: reading, status: status)));
}

class _MeterLoaded extends Equatable {
  final String reading;
  final String status;

  _MeterLoaded({required this.reading, required this.status});

  @override
  // TODO: implement props
  List<Object?> get props => [reading, status];
}
