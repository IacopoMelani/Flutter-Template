import 'package:flutter/material.dart';

mixin MySnackBar {
  void show(BuildContext context, String message, Color color, IconData icon) {
    _show(context, message, color, icon);
  }

  void showError(BuildContext context, String error) {
    _show(context, error, Colors.red, Icons.error);
  }

  void showInfo(BuildContext context, String info) {
    _show(context, info, Colors.blue, Icons.info);
  }

  void showSuccess(BuildContext context, String success) {
    _show(context, success, Colors.green, Icons.check_circle);
  }

  void showWarning(BuildContext context, String warning) {
    _show(context, warning, Colors.orange, Icons.warning);
  }

  void _show(BuildContext context, String message, Color color, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: []
              ..add(
                WidgetSpan(
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
              )
              ..add(
                WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text(
                      ' $message',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ),
        ),
        backgroundColor: color,
      ),
    );
  }
}
