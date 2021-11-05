import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// Return the eventually onTap callback for the list item.
  void Function()? onTapHandler();
}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String title;

  HeadingItem({required this.title});

  @override
  Widget buildTitle(BuildContext context) => Container(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  @override
  void Function()? onTapHandler() => null;
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String title;
  final IconData icon;
  final void Function()? onTap;
  final bool showChevronRight;

  MessageItem({
    required this.title,
    required this.icon,
    this.onTap,
    this.showChevronRight = true,
  });

  @override
  Widget buildTitle(BuildContext context) => Container(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4),
              child: Icon(icon),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (showChevronRight)
                    Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Icon(Icons.chevron_right),
                    ),
                ],
              ),
            ),
          ],
        ),
      );

  @override
  void Function()? onTapHandler() => onTap;
}
