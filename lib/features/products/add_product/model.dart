part of 'bloc.dart';

class AddProductData {

  late final int id;

  AddProductData.fromJson(Map<String, dynamic> json){
    id = json['id'];
  }


}