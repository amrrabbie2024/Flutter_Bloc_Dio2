part of 'bloc.dart';

class VMoviesStates{}

class VMoviesLoadingState extends VMoviesStates{}

class VMoviesFailedState extends VMoviesStates{
  final String msg;

  VMoviesFailedState({required this.msg});
}

class VMoviesSuccessState extends VMoviesStates{
  final List<VMovieModel> moviesList;

  VMoviesSuccessState({required this.moviesList});
}

class VMoviesPaginationState extends VMoviesStates{
  final String? msg;

  VMoviesPaginationState(this.msg);
}

class VMoviesPaginationFinishedState extends VMoviesStates{
  final String? msg;

  VMoviesPaginationFinishedState(this.msg);
}