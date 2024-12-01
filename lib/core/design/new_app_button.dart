import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyNewButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const MyNewButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
        child: FilledButton(onPressed: onPressed, child: Text(text)));
  }
}
