part of 'bloc.dart';

class VRegsisterData {

  late final String message;

  VRegsisterData.fromJson(Map<String, dynamic> json){
    message = json['message'];
  }


}