part of 'bloc.dart';

class AdMoviesStates{}

class AdMoviesLoadingState extends AdMoviesStates{}

class AdMoviesPaginationState extends AdMoviesStates{
  final String? msg;

  AdMoviesPaginationState({this.msg});
}

class AdMoviesPaginationFinshedState extends AdMoviesStates{
  final String? msg;

  AdMoviesPaginationFinshedState({this.msg});
}

class AdMoviesFailedState extends AdMoviesStates{
  final String msg;

  AdMoviesFailedState({required this.msg});
}

class AdMoviesSuccessState extends AdMoviesStates{
  final List<AdMovies> movies;

  AdMoviesSuccessState({required this.movies});
}