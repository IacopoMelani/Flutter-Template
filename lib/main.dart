// @author  ninan

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_btmnavbar/styles/color.dart';
import 'package:flutter_btmnavbar/views/main_view.dart';

void main() {
  runApp(MyApp());
}

//This widget is the main widget.
class MyApp extends StatelessWidget {
  static const String appTitle = 'Bottom Nav Bar';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return AdaptiveTheme(
      light: ColorApp.lightTheme,
      dark: ColorApp.darkTheme,
      initial: AdaptiveThemeMode.system,
      builder: (light, dark) => MaterialApp(
        title: appTitle,
        theme: light,
        darkTheme: dark,
        home: MainView(),
      ),
    );
  }
}
