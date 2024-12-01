part of 'bloc.dart';

class PMoviesStates{}

class PMoviesLoadingState extends PMoviesStates{}

class PMoviesPaginationState extends PMoviesStates{}

class PMoviesPaginationFinishedState extends PMoviesStates{
  final String? msg;

  PMoviesPaginationFinishedState({this.msg});
}

class PMoviesFailedState extends PMoviesStates{
  final String msg;

  PMoviesFailedState({required this.msg});
}

class PMoviesSucessState extends PMoviesStates{
 final  List<PMovieModel> movieModel;

 PMoviesSucessState({required this.movieModel});
}



