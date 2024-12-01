part of 'bloc.dart';

class WeatherEvents{}

class getWeatherDataEvent extends WeatherEvents{
  final String q;

  getWeatherDataEvent({required this.q});
}