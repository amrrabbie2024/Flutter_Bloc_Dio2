part of 'bloc.dart';

class VProfileStates{}

class VProfileLoadingState extends VProfileStates{}

class VProfileFailedState extends VProfileStates{
  final String msg;

  VProfileFailedState({required this.msg});
}

class VProfileSuccessState extends VProfileStates{
  final VProfileData data;

  VProfileSuccessState({required this.data});
}