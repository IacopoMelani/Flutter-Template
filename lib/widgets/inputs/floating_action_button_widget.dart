import 'package:flutter/material.dart';
import 'package:flutter_btmnavbar/styles/color.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  static const IconData defaultIcon = Icons.phone;

  final VoidCallback? onPressed;
  final IconData icon;

  const FloatingActionButtonWidget({
    Key? key,
    this.onPressed,
    this.icon = defaultIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        onPressed: this.onPressed,
        backgroundColor: ColorApp.floatingActionButtonColor(context),
        child: Icon(
          this.icon,
          color: ColorApp.floatingActionButtonIconColor,
        ),
      );
}
