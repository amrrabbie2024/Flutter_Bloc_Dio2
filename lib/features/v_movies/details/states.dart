part of 'bloc.dart';


class VMovieDetailsStates{}

class VMovieDetailsLoadingState extends VMovieDetailsStates{}

class VMovieDetailsFailedState extends VMovieDetailsStates{
  final String msg;

  VMovieDetailsFailedState({required this.msg});
}

class VMovieDetailsSuccessState extends VMovieDetailsStates{
  final VMovieDetailsData data;

  VMovieDetailsSuccessState({required this.data});
}