part of 'bloc.dart';

class AddProductStates{}

class AddProductLoadingState extends AddProductStates{}

class AddProductFailedState extends AddProductStates{
  final String msg;

  AddProductFailedState({required this.msg});
}

class AddProductSuccessState extends AddProductStates{
  final AddProductData data;

  AddProductSuccessState({required this.data});
}