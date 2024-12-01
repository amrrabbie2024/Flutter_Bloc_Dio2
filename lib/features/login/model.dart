part of 'bloc.dart';

class LoginData {

  late final LoginModel model;
  late final String status;
  late final String message;

  LoginData.fromJson(Map<String, dynamic> json){
    model = LoginModel.fromJson(json['data']);
    status = json['status'];
    message = json['message'];
  }


}

class LoginModel {

  late final int id;
  late final String fullname;
  late final String phone;
  late final String email;
  late final String image;
  late final int isBan;
  late final bool isActive;
  late final int unreadNotifications;
  late final String userType;
  late final String token;
  late final Null city;
  late final Null identityNumber;
  late final int userCartCount;

  LoginModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    fullname = json['fullname'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    isBan = json['is_ban'];
    isActive = json['is_active'];
    unreadNotifications = json['unread_notifications'];
    userType = json['user_type'];
    token = json['token'];
    city = null;
    identityNumber = null;
    userCartCount = json['user_cart_count'];
  }


}

