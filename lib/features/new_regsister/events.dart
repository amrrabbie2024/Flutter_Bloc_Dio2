part of 'bloc.dart';

class NRegsisterEvents{}

class getNRegsisterDataEvent extends NRegsisterEvents{
  final String fullname,password,password_confirmation,phone;

  getNRegsisterDataEvent(
      {required this.fullname,required this.password,required this.password_confirmation,required this.phone});
}