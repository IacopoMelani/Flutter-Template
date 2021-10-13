import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_btmnavbar/views/pages/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) => new Center(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => setState(
                      () => AdaptiveTheme.of(context).toggleThemeMode(),
                    ),
                    child: Text('Toggle theme'),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Theme mode: '),
                  Text(AdaptiveTheme.of(context).mode.name),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _logout,
                    child: Text('Logout'),
                  )
                ],
              ),
            ],
          ),
        ),
      );

  void _logout() async {
    (await SharedPreferences.getInstance()).setBool("loggedIn", false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginView(),
      ),
    );
  }
}
