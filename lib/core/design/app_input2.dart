import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppInput2 extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final bool obscureText ;
  final TextInputType? keyboardType;
  final Widget? prefix;
  final Widget? suffix;
  final String? labelText;
  final String? hintText;
  final void Function(String)? onFieldSubmitted;
  const AppInput2({super.key, this.controller, this.validator,  this.obscureText=false, this.keyboardType, this.prefix, this.suffix, this.labelText, this.hintText, this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefix: prefix,
        suffix: suffix,
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: Theme.of(context).primaryColor)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: Theme.of(context).primaryColor)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: Theme.of(context).primaryColor)
        ),
      ),
    );
  }
}
