import 'package:flutter/material.dart';

enum TextFieldType {
  search,
  text,
}

class MyTextField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? autofocus;
  final bool? obscureText;
  final bool? autocorrect;
  final TextFieldType type;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const MyTextField({
    Key? key,
    required this.labelText,
    this.type = TextFieldType.text,
    this.hintText,
    this.autocorrect,
    this.autofocus,
    this.controller,
    this.keyboardType,
    this.prefixIcon,
    this.obscureText,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextField(
        autofocus: autofocus ?? false,
        controller: controller,
        keyboardType: keyboardType,
        autocorrect: false,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon != null ? prefixIcon : null,
          suffixIcon: suffixIcon != null ? suffixIcon : null,
          border: OutlineInputBorder(
            borderRadius: type == TextFieldType.search ? BorderRadius.circular(10) : BorderRadius.circular(4),
          ),
        ),
      );
}
