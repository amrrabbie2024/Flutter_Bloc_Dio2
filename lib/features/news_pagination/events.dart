part of 'bloc.dart';

class NewsEvents{}

class getNewsDataEvent extends NewsEvents{
  final String q,from,to;

  getNewsDataEvent({required this.q,required this.from,required this.to});
}