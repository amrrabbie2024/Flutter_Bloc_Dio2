part of 'bloc.dart';
class ANewsStates{}

class AnewsLoadingState extends ANewsStates{}

class AnewsFailedState extends ANewsStates{
  final String msg;

  AnewsFailedState({required this.msg});
}

class AnewsSuccessState extends ANewsStates{
  final List<AArticles> articles;

  AnewsSuccessState({required this.articles});
}

class AnewsPaginationState extends ANewsStates{
  final String? msg;

  AnewsPaginationState({ this.msg});
}

class AnewsPaginationFinishedState extends ANewsStates{
  final String? msg;

  AnewsPaginationFinishedState({this.msg});
}