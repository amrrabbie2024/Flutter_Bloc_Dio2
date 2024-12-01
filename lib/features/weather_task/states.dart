part of 'bloc.dart';

class TWeatherStates{}

class TWeatherWelcomeState extends TWeatherStates{}

class TWeatherFailedState extends TWeatherStates{
  final String msg;

  TWeatherFailedState({required this.msg});
}

class TWeatherSuccessState extends TWeatherStates{
  final TWeatherData weatherData;

  TWeatherSuccessState({required this.weatherData});
}

class TWeatherHotState extends TWeatherStates{}

class TWeatherNotHotState extends TWeatherStates{}