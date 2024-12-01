part of 'bloc.dart';

class AllProductsStates{}

class ALlProductsLoadingState extends AllProductsStates{}

class ALlProductsFailedState extends AllProductsStates{
  final String msg;

  ALlProductsFailedState({required this.msg});
}

class ALlProductsSuccessState extends AllProductsStates{
 final List<AllProductsModel> data;

 ALlProductsSuccessState({required this.data});
}

