import 'package:flutter/material.dart';

mixin MySnackBar<T extends StatefulWidget> on State<T> {
  void showError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
      ),
    );
  }
}
