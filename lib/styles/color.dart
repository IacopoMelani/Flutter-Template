import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class ColorApp {
  static final Color primaryColorLight = Colors.green;
  static final Color secondaryColorLight = Colors.greenAccent;
  static final Color primaryTextColorLight = Colors.white;
  static final Color secondaryTextColorLight = Colors.black;

  static final Color primaryColorDark = Colors.green;
  static final Color secondaryColorDark = Colors.greenAccent;
  static final Color primaryTextColorDark = Colors.white;
  static final Color secondaryTextColorDark = Colors.black;

  static final Color backgroundColorLight = Colors.white;
  static final Color backgroundColorDark = Colors.grey.shade800;

  static final Color iconPressedLight = Colors.green;
  static final Color iconUnpressedLight = Colors.black;

  static final Color iconPressedDark = Colors.green;
  static final Color iconUnpressedDark = Colors.white;

  static final Color floatingActionButtonColorLight = Colors.green;
  static final Color floatingActionButtonColorDark = Colors.green;

  static ThemeData get lightTheme => ThemeData(
        colorScheme: ColorScheme.light(
          primary: ColorApp.primaryColorLight,
          onPrimary: ColorApp.primaryTextColorLight,
          secondary: ColorApp.secondaryColorLight,
          onSecondary: ColorApp.secondaryTextColorLight,
          background: ColorApp.backgroundColorLight,
          onBackground: ColorApp.backgroundColorLight,
          brightness: Brightness.light,
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        colorScheme: ColorScheme.dark(
          primary: ColorApp.primaryColorDark,
          onPrimary: ColorApp.primaryTextColorDark,
          secondary: ColorApp.secondaryColorDark,
          onSecondary: ColorApp.secondaryTextColorDark,
          background: ColorApp.backgroundColorDark,
          onBackground: ColorApp.backgroundColorDark,
          brightness: Brightness.dark,
        ),
      );

  static bool isDarkMode(BuildContext context) {
    return AdaptiveTheme.of(context).mode.isDark;
  }

  static bool isLightMode(BuildContext context) {
    return !isDarkMode(context);
  }

  static Color floatingActionButtonColor(BuildContext context) {
    if (isDarkMode(context)) {
      return floatingActionButtonColorDark;
    } else {
      return floatingActionButtonColorLight;
    }
  }

  static const Color floatingActionButtonIconColor = Colors.white;

  static Color iconPressed(BuildContext context) {
    return isDarkMode(context) ? iconPressedDark : iconPressedLight;
  }

  static Color iconUnpressed(BuildContext context) {
    return isDarkMode(context) ? iconUnpressedDark : iconUnpressedLight;
  }
}
