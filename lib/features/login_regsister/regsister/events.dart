part of 'bloc.dart';

class ASignupEvents{}

class PostASignupEvent extends ASignupEvents{
  final String fullname,password,password_confirmation,phone;

  PostASignupEvent(
      {required this.fullname,required this.password,required this.password_confirmation,required this.phone});
}