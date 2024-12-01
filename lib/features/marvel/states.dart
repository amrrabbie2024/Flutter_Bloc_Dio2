part of 'bloc.dart';

class MarvelStates{}

class MarvelLoadingState extends MarvelStates{}

class MarvelPaginationState extends MarvelStates{
  final String? msg;

  MarvelPaginationState({this.msg});
}

class MarvelPaginationFinishedState extends MarvelStates{
  final String? msg;

  MarvelPaginationFinishedState({this.msg});
}

class MarvelFailedState extends MarvelStates{
  final String msg;

  MarvelFailedState({required this.msg});
}

class MarvelSuccessState extends MarvelStates{
  final List<MarvelModel> marvelsList;

  MarvelSuccessState({required this.marvelsList});
}