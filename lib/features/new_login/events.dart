part of 'bloc.dart';

class NLoginEvents{}

class getNLoginDataEvent extends NLoginEvents{
  final String phone,password;

  getNLoginDataEvent({required this.phone,required this.password});
}