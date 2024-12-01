part of 'bloc.dart';

class UpdateProductEvents{}

class putUpdateProductEvent extends UpdateProductEvents{
  final String title,price,description,image,category;
  final num id;

  putUpdateProductEvent(
      {required this.title,required this.price,required this.description,required this.image,required this.category, required this.id });
}