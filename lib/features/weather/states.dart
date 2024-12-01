part of 'bloc.dart';

class WeatherStates{}

class WeatherLoadingState extends WeatherStates{}

class WeatherFailedState extends WeatherStates{
  final String msg;

  WeatherFailedState({required this.msg});
}

class WeatherSuccessState extends WeatherStates{
  final WeatherData weatherData;

  WeatherSuccessState({required this.weatherData});
}