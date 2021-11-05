import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          title,
        ),
      );

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
