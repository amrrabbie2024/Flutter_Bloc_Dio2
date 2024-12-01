part of 'bloc.dart';

class AllCategoriesStates{}

class AllCategoriesLoadingState extends AllCategoriesStates{}

class AllCategoriesFailedState extends AllCategoriesStates{
  final String msg;

  AllCategoriesFailedState({required this.msg});
}

class AllCategoriesSuccessState extends AllCategoriesStates{
  final List<String> categories;

  AllCategoriesSuccessState({required this.categories});
}