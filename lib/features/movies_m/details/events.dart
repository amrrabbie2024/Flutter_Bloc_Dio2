part of 'bloc.dart';

class MovieMDetailsEvents{}

class getMovieMDetailsDataEvent extends MovieMDetailsEvents{
  final int id;

  getMovieMDetailsDataEvent({required this.id});
}