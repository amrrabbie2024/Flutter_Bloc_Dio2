part of 'bloc.dart';

class ZMovieDetailsEvents{}

class GetZMovieDetailsDataEvent extends ZMovieDetailsEvents{
  final int id;

  GetZMovieDetailsDataEvent({required this.id});
}