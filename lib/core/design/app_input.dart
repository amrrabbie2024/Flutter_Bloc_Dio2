import 'package:flutter/material.dart';

class MyAppInput extends StatelessWidget {
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String? value)? validator;
  final String? hintText;
  final String? labelText;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? keyboardType;
  const MyAppInput({super.key, this.controller,  this.obscureText=false, this.validator, this.hintText, this.labelText, this.prefix, this.suffix, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefix: prefix,
        suffix: suffix,
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Theme.of(context).primaryColor)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Theme.of(context).primaryColor)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.orangeAccent)
        ),
      ),
    );
  }
}
