part of 'bloc.dart';

class VWeatherEvents{}

class getVWeatherDataEvent extends VWeatherEvents{
  final String q;

  getVWeatherDataEvent({required this.q});
}