import 'package:flutter/material.dart';

class MyCircularProgressIndicator extends StatelessWidget {
  final double strokeWidth;

  const MyCircularProgressIndicator({Key? key, this.strokeWidth = 2}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(
          strokeWidth: this.strokeWidth,
        ),
      );
}
