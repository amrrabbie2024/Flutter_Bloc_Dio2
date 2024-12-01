part of 'bloc.dart';

class TWeatherEvents{}

class getTWeatherDataEvent extends TWeatherEvents{
  final String city;

  getTWeatherDataEvent({required this.city});
}