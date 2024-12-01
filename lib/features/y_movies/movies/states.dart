part of 'bloc.dart';

class YMoviesStates{}

class YMoviesLoadingState extends YMoviesStates{}

class YMoviesFailedState extends YMoviesStates{
  final String msg;

  YMoviesFailedState({required this.msg});
}

class YMoviesSuccessState extends YMoviesStates{
  final List<YMovieModel> moviesList;

  YMoviesSuccessState({required this.moviesList});
}

class YMoviesPaginationState extends YMoviesStates{
  final String? msg;

  YMoviesPaginationState({this.msg});
}

class YMoviesPaginationFinishedState extends YMoviesStates{
  final String? msg;

  YMoviesPaginationFinishedState({this.msg});
}