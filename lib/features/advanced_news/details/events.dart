part of 'bloc.dart';

class AdMovieDetailsEvents{}

class getAdMovieDetailsDataEvent extends AdMovieDetailsEvents{
  final int id;

  getAdMovieDetailsDataEvent({required this.id});
}