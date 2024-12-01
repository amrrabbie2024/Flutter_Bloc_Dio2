import 'package:flutter/material.dart';

class MyNewInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefix;
  final Widget? suffix;
  final String? hintText;
  final String? labelText;
  const MyNewInput({super.key, this.controller, this.validator,  this.obscureText=false, this.keyboardType, this.prefix, this.suffix, this.hintText, this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Color(0xff825d47)),
        labelText: labelText,
        labelStyle: TextStyle(color: Color(0xff825d47)),
        prefix: prefix,
        suffix: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0xff825d47))
        ),
        enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Color(0xff825d47))
        ),
        focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Color(0xff825d47))
        ),
      ),
    );
  }
}
