// @author  ninan

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_btmnavbar/bloc/auth/auth_bloc.dart';
import 'package:flutter_btmnavbar/bloc/auth/auth_event.dart';
import 'package:flutter_btmnavbar/bloc/auth/auth_state.dart';
import 'package:flutter_btmnavbar/bloc/login/login_bloc.dart';
import 'package:flutter_btmnavbar/bloc/logout/logout_bloc.dart';
import 'package:flutter_btmnavbar/services/auth_services.dart';
import 'package:flutter_btmnavbar/styles/color.dart';
import 'package:flutter_btmnavbar/views/main_view.dart';
import 'package:flutter_btmnavbar/views/pages/login_view.dart';

void main() => runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthService>(
            create: (context) => FakeAuthenticationService(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(RepositoryProvider.of<AuthService>(context))
                ..add(
                  AppLoadedAuthEvent(),
                ),
            ),
            BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(
                BlocProvider.of<AuthBloc>(context),
                RepositoryProvider.of<AuthService>(context),
              ),
            ),
            BlocProvider<LogoutBloc>(
              create: (context) => LogoutBloc(
                BlocProvider.of<AuthBloc>(context),
              ),
            ),
          ],
          child: App(),
        ),
      ),
    );

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
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
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticatedState) {
              return MainView();
            } else {
              return LoginView();
            }
          },
        ),
      ),
    );
  }
}
