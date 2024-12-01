part of 'bloc.dart';

class ZMovieDetailsStates{}

class ZMovieDetailsLoadingState extends ZMovieDetailsStates{}

class ZMovieDetailsFailedState extends ZMovieDetailsStates{
  final String msg;

  ZMovieDetailsFailedState({required this.msg});
}

class ZMovieDetailsSuccessState extends ZMovieDetailsStates{
  final ZMovieDetailsData data;

  ZMovieDetailsSuccessState({required this.data});
}