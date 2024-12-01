part of 'bloc.dart';

class VMovieDetailsEvents{}

class getVMovieDetailsDataEvent extends VMovieDetailsEvents{
  final int id;

  getVMovieDetailsDataEvent({required this.id});
}