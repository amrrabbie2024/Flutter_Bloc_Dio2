part of 'bloc.dart';

class ALoginStates{}

class ALoginLoadingState extends ALoginStates{}

class ALoginFailedState extends ALoginStates{
  final String msg;

  ALoginFailedState({required this.msg});
}

class ALoginSuccessState extends ALoginStates{
  final ALoginData loginData;

  ALoginSuccessState({required this.loginData});
}