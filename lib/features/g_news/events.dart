part of 'bloc.dart';

class GNewsEvents{}

class getGNewsDataEvent extends GNewsEvents{
  final String category;

  getGNewsDataEvent({required this.category});
}