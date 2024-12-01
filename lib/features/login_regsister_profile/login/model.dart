part of 'bloc.dart';

class VLoginData {

  late final String message;
  late final String token;

  VLoginData.fromJson(Map<String, dynamic> json){
    message = json['message'];
    token = json['token'];
  }


}