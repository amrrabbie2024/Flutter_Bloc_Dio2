import 'package:flutter/material.dart';

class MyAppFailed extends StatelessWidget {

  final String msg;
  const MyAppFailed({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(msg,style: TextStyle(color: Colors.red,fontSize: 24,fontWeight: FontWeight.bold),));
  }
}
