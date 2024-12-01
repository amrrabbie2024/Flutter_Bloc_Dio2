part of 'bloc.dart';

class MovieDetailsStates{}

class MovieDetailsLoadingState extends MovieDetailsStates{}

class MovieDetailsFailedState extends MovieDetailsStates{
  final String msg;

  MovieDetailsFailedState({required this.msg});
}

class MovieDetailsSucessState extends MovieDetailsStates{
  final MovieDetailsData movieDetailsData;

  MovieDetailsSucessState({required this.movieDetailsData});
}