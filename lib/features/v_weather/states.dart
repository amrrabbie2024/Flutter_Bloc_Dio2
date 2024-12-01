part of 'bloc.dart';

class VWeatherStates{}

class VWeatherInitialState extends VWeatherStates{}

class VWeatherHotState extends VWeatherStates{}

class VWeatherNotHotState extends VWeatherStates{}

class VWeatherLoadingState extends VWeatherStates{}

class VWeatherFailedState extends VWeatherStates{
  final String msg;

  VWeatherFailedState({required this.msg});
}

class VWeatherSuccessState extends VWeatherStates{
  final VWeatherData data;

  VWeatherSuccessState({required this.data});
}