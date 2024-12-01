part of 'bloc.dart';

class SignupData {

  late final String status;
  late final Null data;
  late final String message;
  late final int devMessage;

  SignupData.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = null;
    message = json['message'];
    devMessage = json['dev_message'];
  }


}