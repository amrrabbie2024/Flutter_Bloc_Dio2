part of 'bloc.dart';

class VRegsisterStates{}

class VRegsisterLoadingState extends VRegsisterStates{}

class VRegsisterFailedState extends VRegsisterStates{
  final String msg;

  VRegsisterFailedState({required this.msg});
}

class VRegsisterSuccessState extends VRegsisterStates{
  final VRegsisterData data;

  VRegsisterSuccessState({required this.data});
}