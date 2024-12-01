part of 'bloc.dart';

class NRegsisterStates{}

class NRegsisterLoadingState extends NRegsisterStates{}

class NRegsisterFailedState extends NRegsisterStates{
  final String msg;

  NRegsisterFailedState({required this.msg});
}

class NRegsisterSuccessState extends NRegsisterStates{
  final NRegsisterData regsisterData;

  NRegsisterSuccessState({required this.regsisterData});
}