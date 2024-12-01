part of 'bloc.dart';

class RegsisterStates{}

class RegsisterLoadingState extends RegsisterStates{}

class RegsisterFailedState extends RegsisterStates{
  final String msg;

  RegsisterFailedState({required this.msg});
}

class RegsisterSuccessState extends RegsisterStates{
  final SignupData signupData;

  RegsisterSuccessState({required this.signupData});
}