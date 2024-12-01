part of 'bloc.dart';

class LoginEvents{}

class GetLoginDataEvent extends  LoginEvents{
  final String phone,password;

  GetLoginDataEvent({required this.phone,required this.password});
}