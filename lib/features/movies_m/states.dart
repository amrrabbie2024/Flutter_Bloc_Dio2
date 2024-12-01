part of 'bloc.dart';

class MoviesMStates{}

class MoviesMLoadingState extends MoviesMStates{}

class MoviesMFailedState extends MoviesMStates{
  final String msg;

  MoviesMFailedState({required this.msg});
}

class MoviesMSuccessState extends MoviesMStates{
  final List<MovieM> moviesList;

  MoviesMSuccessState({required this.moviesList});
}

class MoviesMPaginationState extends MoviesMStates{
  final String? msg;

  MoviesMPaginationState({this.msg});
}

class MoviesMPaginationFinsihedState extends MoviesMStates{
  final String? msg;

  MoviesMPaginationFinsihedState({this.msg});
}