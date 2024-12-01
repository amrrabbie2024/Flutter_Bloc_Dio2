part of 'bloc.dart';

class RegisiterEvents{}

class GetRegsisterDataEvent extends RegisiterEvents{
  final String fullname,password,password_confirmation,phone;

  GetRegsisterDataEvent(
      {required this.fullname,required this.password,required this.password_confirmation,required this.phone});
}