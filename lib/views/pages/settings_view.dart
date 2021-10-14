import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_btmnavbar/bloc/logout/logout_bloc.dart';
import 'package:flutter_btmnavbar/bloc/logout/logout_event.dart';
import 'package:flutter_btmnavbar/bloc/logout/logout_state.dart';

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
                  BlocBuilder<LogoutBloc, LogoutState>(
                    builder: (context, state) => ElevatedButton(
                      onPressed: state is LogoutLoadingState ? null : _logout,
                      child: Text('Logout'),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );

  void _logout() async {
    final state = BlocProvider.of<LogoutBloc>(context).state;
    if (state is LogoutLoadingState) {
      return;
    }
    final logoutBloc = BlocProvider.of<LogoutBloc>(context);
    logoutBloc.add(LogoutPressedEvent());
  }
}
