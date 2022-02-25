part of 'getweather_cubit.dart';

abstract class GetweatherState extends Equatable {
  const GetweatherState();

  @override
  List<Object> get props => [];
}

class GetweatherInitial extends GetweatherState {}

class GetweatherLoading extends GetweatherState {}

class GetweatherLoaded extends GetweatherState {
  final RefinedWeatherModel model;
  final String? lastSearched;
  const GetweatherLoaded({
    required this.model,
    required this.lastSearched,
  });
  @override
  List<Object> get props => [model, lastSearched!];
}

class GetweatherFailed extends GetweatherState {
  final AppErrorType type;
  const GetweatherFailed({required this.type});
  @override
  List<Object> get props => [type];
}
