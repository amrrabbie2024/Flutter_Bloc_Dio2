part of 'bloc.dart';

class ZMoviesStates{}

class ZMoviesLoadingState extends ZMoviesStates{}

class ZMoviesFailedState extends ZMoviesStates{
  final String msg;

  ZMoviesFailedState({required this.msg});
}

class ZMoviesSuccessState extends ZMoviesStates{
  final List<ZMovies> moviesList;

  ZMoviesSuccessState({required this.moviesList});
}

class ZMoviesPaginationState extends ZMoviesStates{
  final String? msg;

  ZMoviesPaginationState({this.msg});
}

class ZMoviesPaginationFinishedState extends ZMoviesStates{
  final String? msg;

  ZMoviesPaginationFinishedState({this.msg});
}