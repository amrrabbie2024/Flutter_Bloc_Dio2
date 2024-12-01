part of 'bloc.dart';

class UpdateProductData {

  late final int id;
  late final String title;
  late final String price;
  late final String description;
  late final String image;
  late final String category;

  UpdateProductData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    category = json['category'];
  }


}