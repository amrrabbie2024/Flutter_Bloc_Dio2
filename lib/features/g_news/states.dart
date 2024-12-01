part of 'bloc.dart';

class GNewsStates{}

class GNewsLoadingState extends GNewsStates{}

class GNewsFailedState extends GNewsStates{
  final String msg;

  GNewsFailedState({required this.msg});
}

class GNewsSuccessState extends GNewsStates{
  final List<GArticles> data;

  GNewsSuccessState({required this.data});
}

class GNewsPaginationState extends GNewsStates{
  final String? msg;

  GNewsPaginationState({required this.msg});
}

class GNewsPaginationFinishedState extends GNewsStates{
  final String? msg;

  GNewsPaginationFinishedState({required this.msg});
}