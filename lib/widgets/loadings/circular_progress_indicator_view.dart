import 'package:flutter/material.dart';

class MyCircularProgressIndicatorView extends StatelessWidget {
  final double strokeWidth;

  const MyCircularProgressIndicatorView({Key? key, this.strokeWidth = 2}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: this.strokeWidth,
          ),
        ),
      );
}
