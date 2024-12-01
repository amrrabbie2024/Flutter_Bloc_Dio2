part of 'bloc.dart';

class MoviesStates{}

class MoviesLoadingState extends MoviesStates{}

class MoviesFailedState extends MoviesStates{
  final String msg;

  MoviesFailedState({required this.msg});
}

class MoviesSucessState extends MoviesStates{
  final List<MovieModel>  movieModel;

  MoviesSucessState({required this.movieModel});
}