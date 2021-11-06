import 'dart:async';

import 'package:flutter/material.dart';

enum TextFieldType {
  search,
  text,
}

class MyTextField extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? autofocus;
  final bool? obscureText;
  final bool? autocorrect;
  final TextFieldType type;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const MyTextField({
    Key? key,
    required this.labelText,
    this.type = TextFieldType.text,
    this.hintText,
    this.autocorrect,
    this.autofocus,
    this.onChanged,
    this.controller,
    this.keyboardType,
    this.prefixIcon,
    this.obscureText,
    this.suffixIcon,
    this.validator,
  }) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  Timer? _debounce;

  @override
  Widget build(BuildContext context) => this.widget.validator == null
      ? TextField(
          autofocus: this.widget.autofocus ?? false,
          controller: this.widget.controller,
          keyboardType: this.widget.keyboardType,
          autocorrect: false,
          obscureText: this.widget.obscureText ?? false,
          onChanged: this.widget.onChanged != null ? onSearchChanged : null,
          decoration: InputDecoration(
            labelText: this.widget.labelText,
            hintText: this.widget.hintText,
            prefixIcon: this.widget.prefixIcon != null ? this.widget.prefixIcon : null,
            suffixIcon: this.widget.suffixIcon != null ? this.widget.suffixIcon : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        )
      : TextFormField(
          autofocus: this.widget.autofocus ?? false,
          controller: this.widget.controller,
          keyboardType: this.widget.keyboardType,
          autocorrect: false,
          obscureText: this.widget.obscureText ?? false,
          validator: this.widget.validator,
          onChanged: this.widget.onChanged != null ? onSearchChanged : null,
          decoration: InputDecoration(
            labelText: this.widget.labelText,
            hintText: this.widget.hintText,
            prefixIcon: this.widget.prefixIcon != null ? this.widget.prefixIcon : null,
            suffixIcon: this.widget.suffixIcon != null ? this.widget.suffixIcon : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void onSearchChanged(String value) {
    if (this._debounce?.isActive ?? false) {
      this._debounce?.cancel();
    }

    this._debounce = Timer(const Duration(milliseconds: 500), () => this.widget.onChanged?.call(value));
  }
}
