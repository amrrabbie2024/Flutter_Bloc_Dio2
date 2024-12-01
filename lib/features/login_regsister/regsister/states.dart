part of 'bloc.dart';

class ASignupStates{}

class ASignupLoadingState extends ASignupStates{}

class ASignupFailedState extends ASignupStates{
  final String msg;

  ASignupFailedState({required this.msg});
}

class ASignupSuccessState extends ASignupStates{
  final ASignupData signupData;

  ASignupSuccessState({required this.signupData});
}