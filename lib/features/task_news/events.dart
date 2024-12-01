part of 'bloc.dart';

class ANewsEvents{}

class getANewsDataEvent extends ANewsEvents{
  final String country,category;

  getANewsDataEvent({ this.country="us",required this.category});
}