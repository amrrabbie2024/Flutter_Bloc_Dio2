part of 'bloc.dart';

class VLoginStates{}

class VLoginLoadingState extends VLoginStates{}

class VLoginFailedState extends VLoginStates{
  final String msg;

  VLoginFailedState({required this.msg});
}

class VLoginSuccessState extends VLoginStates{
  final VLoginData data;

  VLoginSuccessState({required this.data});
}