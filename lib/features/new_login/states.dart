part of 'bloc.dart';

class NLoginStates{}

class NLoginLoadingState extends NLoginStates{}

class NLoginFailedState extends NLoginStates{
  final String msg;

  NLoginFailedState({required this.msg});
}

class NLoginSuccessState extends NLoginStates{
  final NLoginModel loginModel;

  NLoginSuccessState({required this.loginModel});
}