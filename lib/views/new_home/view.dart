import 'package:flutter/material.dart';

class MyNHomeView extends StatefulWidget {
  final String fullname;
  const MyNHomeView({super.key, required this.fullname});

  @override
  State<MyNHomeView> createState() => _MyNHomeViewState();
}

class _MyNHomeViewState extends State<MyNHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffeeb39),
      appBar: AppBar(
        title: Text("Welcome, ${widget.fullname}"),
      ),
    );
  }
}
