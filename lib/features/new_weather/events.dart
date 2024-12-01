part of 'bloc.dart';

class MWeatherEvents{}

class getMWeatherDataEvent extends MWeatherEvents{
  final String q;

  getMWeatherDataEvent({required this.q});
}