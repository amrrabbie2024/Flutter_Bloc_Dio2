part of 'bloc.dart';

class WWatherEvents{}

class getWWeatherDataEvent extends WWatherEvents{
  final String q;

  getWWeatherDataEvent({required this.q});
}