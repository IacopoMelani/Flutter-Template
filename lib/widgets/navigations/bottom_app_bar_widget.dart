import 'package:flutter/material.dart';

class BottomAppBarWidget extends StatelessWidget {
  final List<Widget> items;

  const BottomAppBarWidget({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) => BottomAppBar(
        shape: const CircularNotchedRectangle(),
        elevation: 0,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey,
                width: 0.3,
              ),
            ),
          ),
          height: 60.0,
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items,
          ),
        ),
      );
}
