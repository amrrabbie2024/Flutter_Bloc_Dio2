part of 'bloc.dart';

class YWeatherStates{}

class YWeatherInitialState extends YWeatherStates{
  final String? msg;

  YWeatherInitialState(this.msg);
}

class YWeatherLoadingState extends YWeatherStates{}

class YWeatherFailedState extends YWeatherStates{
  final String msg;

  YWeatherFailedState({required this.msg});
}

class YWeatherSuccessState extends YWeatherStates{
  final YWeatherData weatherData;

  YWeatherSuccessState({required this.weatherData});
}

class YWeatherShinyState extends YWeatherStates{}

class YWeatherNotShinyState extends YWeatherStates{}