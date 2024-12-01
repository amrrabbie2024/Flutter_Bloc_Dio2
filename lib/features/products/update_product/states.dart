part of 'bloc.dart';

class UpdateProductStates{}

class UpdateProductLoadingState extends UpdateProductStates{}

class UpdateProductFailedState extends UpdateProductStates{
  final String msg;

  UpdateProductFailedState({required this.msg});
}

class UpdateProductSuccessState extends UpdateProductStates{
  final UpdateProductData data;

  UpdateProductSuccessState({required this.data});
}