part of 'bloc.dart';

class AllProductsModel {


  AllProductsModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating =  Rating.fromJson(json['rating']) ;
  }
 late num id;
 late String title;
 late num price;
 late String description;
 late String category;
 late String image;
 late Rating rating;




}

/// rate : 3.9
/// count : 120

class Rating {


  Rating.fromJson(dynamic json) {
    rate = json['rate'];
    count = json['count'];
  }
 late num rate;
 late num count;



}