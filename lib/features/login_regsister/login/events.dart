part of 'bloc.dart';

class ALoginEvents{}

class PostALoginEvent extends ALoginEvents{
  final String phone,password;

  PostALoginEvent({required this.phone,required this.password});
}