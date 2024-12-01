part of 'bloc.dart';

class MovieMDetailsStates{}

class MovieMDetailsLoadingState extends MovieMDetailsStates{}

class MovieMDetailsFailedState extends MovieMDetailsStates{
  final String msg;

  MovieMDetailsFailedState({required this.msg});
}

class MovieMDetailsSuccessState extends MovieMDetailsStates{
  final MovieMDetailsData details;

  MovieMDetailsSuccessState({required this.details});
}

