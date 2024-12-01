part of 'bloc.dart';

class MWeatherStates{}

class MWeatherLoadingState extends MWeatherStates{}

class MWeatherFailedState extends MWeatherStates{
  final String msg;

  MWeatherFailedState({required this.msg});
}

class MWeatherSuccessState extends MWeatherStates{
  final MWeatherData mWeatherData;

  MWeatherSuccessState({required this.mWeatherData});
}