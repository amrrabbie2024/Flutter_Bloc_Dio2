part of 'bloc.dart';

class VProfileData {

  late final User user;

  VProfileData.fromJson(Map<String, dynamic> json){
    user = User.fromJson(json['user']);
  }


}

class User {

  late final Location location;
  late final String _id;
  late final String name;
  late final String phone;
  late final String email;
  late final List<dynamic> favorites;
  late final String createdAt;

  User.fromJson(Map<String, dynamic> json){
    location = Location.fromJson(json['location']);
    _id = json['_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    favorites = List.castFrom<dynamic, dynamic>(json['favorites']);
    createdAt = json['createdAt'];
  }


}

class Location {

  late final String type;
  late final List<double> coordinates;

  Location.fromJson(Map<String, dynamic> json){
    type = json['type'];
    coordinates = List.castFrom<dynamic, double>(json['coordinates']);
  }


}