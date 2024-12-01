part of 'bloc.dart';

class AdMovieDetailsStates{}

class AdMoviesDetailsLoadingState extends AdMovieDetailsStates{}

class AdMoviesDetailsFailedState extends AdMovieDetailsStates{
  final String msg;

  AdMoviesDetailsFailedState({required this.msg});
}

class AdMoviesDetailsSuccessState extends AdMovieDetailsStates{
  final AdMovieDetailsData movie;

  AdMoviesDetailsSuccessState({required this.movie});
}