part of 'bloc.dart';

class VRegsisterEvents{}

class getVRegsisterDataEvent extends VRegsisterEvents{
  final String name,phone,email,password,confirmPassword;
  final XFile profilePic;

  getVRegsisterDataEvent(
      {required this.name,
        required this.phone,
        required this.email,
        required this.password,
        required this.confirmPassword,
        required this.profilePic}
      );
}