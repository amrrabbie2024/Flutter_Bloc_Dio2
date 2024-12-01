part of 'bloc.dart';

class MovieDetailsEvents{}

class getMovieDetailsDataEvent extends MovieDetailsEvents{
  final int movie_id;

  getMovieDetailsDataEvent({required this.movie_id});
}