part of 'bloc.dart';

class AddProductEvents{}

class postAddProductEvent extends AddProductEvents{
  final String title,description,image,category;
  final String price;

  postAddProductEvent(
      {required this.title,required this.description,required this.image,required this.category,required this.price});
}