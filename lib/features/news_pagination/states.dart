part of 'bloc.dart';

class NewsStates{}

class NewsLoadingState extends NewsStates{}

class NewsFailedState extends NewsStates{
  final String msg;

  NewsFailedState({required this.msg});
}

class NewsSucessState extends NewsStates{
  final List<Articles> articles;

  NewsSucessState({required this.articles});
}

class NewsPaginationState extends NewsStates{
  final String? msg;

  NewsPaginationState({this.msg});
}

class NewsPaginationFinishedState extends NewsStates{
  final String? msg;

  NewsPaginationFinishedState({this.msg});
}