part of 'bloc.dart';

class ASignupData {

  late final String status;
  late final Null data;
  late final String message;
  late final int devMessage;

  ASignupData.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = null;
    message = json['message'];
    devMessage = json['dev_message'];
  }


}