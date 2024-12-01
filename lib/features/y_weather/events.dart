part of 'bloc.dart';

class YweatherEvents{}

class GetYWeatherDataEvent extends YweatherEvents{
  final String q;
  final int days;

  GetYWeatherDataEvent({required this.q,required this.days});
}