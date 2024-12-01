import 'package:flutter/material.dart';

class MyAppLoading extends StatelessWidget {
  const MyAppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.orange,
        backgroundColor: Colors.yellow,
        strokeWidth: 8,
      ),
    );
  }
}
