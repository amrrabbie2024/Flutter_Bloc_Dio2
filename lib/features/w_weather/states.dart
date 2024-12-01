part of 'bloc.dart';

class WWeatherStates{}

class WWeatherLoadingState extends WWeatherStates{}

class WWeatherInitalState extends WWeatherStates{
  final String? msg;

  WWeatherInitalState({this.msg});
}

class WWeatherFailedState extends WWeatherStates{
  final String msg;

  WWeatherFailedState({required this.msg});
}

class WWeatherSuccessState extends WWeatherStates{
  final WWeatherData data;

  WWeatherSuccessState({required this.data});
}