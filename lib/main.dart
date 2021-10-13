// @author  ninan

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_btmnavbar/styles/color.dart';
import 'package:flutter_btmnavbar/views/main_view.dart';
import 'package:flutter_btmnavbar/views/pages/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  static const String appTitle = 'Bottom Nav Bar';

  bool get loggedIn => prefs?.getBool("loggedIn") ?? false;

  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    isUserLoggedIn();
  }

  void isUserLoggedIn() async {
    var prefs = await SharedPreferences.getInstance();
    this.prefs = prefs;
    setState(() => prefs.getBool('loggedIn') ?? false);
  }

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
        home: loggedIn ? MainView() : LoginView(),
      ),
    );
  }
}
