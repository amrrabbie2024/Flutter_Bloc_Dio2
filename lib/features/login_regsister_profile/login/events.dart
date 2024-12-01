part of 'bloc.dart';

class VLoginEvents{}

class getVLoginDataEvent extends VLoginEvents{
  final String email,password;

  getVLoginDataEvent({required this.email,required this.password});
}