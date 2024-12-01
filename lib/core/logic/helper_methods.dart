import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final navigtorKey=GlobalKey<NavigatorState>();

/*void navigateTo(Widget page){
  Navigator.push(navigtorKey.currentContext!, MaterialPageRoute(builder: (context) => page,));
}*/

void navigateTo(Widget page,{bool withHistory=true}){
  Navigator.pushAndRemoveUntil(navigtorKey.currentContext!, MaterialPageRoute(builder: (context) => page,),(route) => withHistory,);
}

void showMessage(String msg,{bool isSucess=false}){
  if(msg != null) {
    ScaffoldMessenger.of(navigtorKey.currentContext!).showSnackBar(SnackBar(
        backgroundColor: isSucess == true ? Colors.green : Colors.red,

        content: Center(child: Text(msg))));
  }
}

Future uploadImageToApi(XFile img) async {
  return MultipartFile.fromFile(
    img.path,
    filename: img.path
        .split('/')
        .last,
  );
}