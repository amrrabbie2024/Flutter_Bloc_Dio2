part of 'bloc.dart';

class AllProductsEvents{}

class getAllProductsDataEvent extends AllProductsEvents{}

class getAllProductsByCategoryDataEvent extends AllProductsEvents{
  final String category_name;

  getAllProductsByCategoryDataEvent({required this.category_name});
}