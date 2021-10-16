// @author  ninan

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_btmnavbar/bloc/auth/auth_bloc.dart';
import 'package:flutter_btmnavbar/bloc/auth/auth_state.dart';
import 'package:flutter_btmnavbar/bloc/config/config_bloc.dart';
import 'package:flutter_btmnavbar/bloc/config/config_state.dart';
import 'package:flutter_btmnavbar/bloc/connectivity/connectivity_bloc.dart';
import 'package:flutter_btmnavbar/bloc/connectivity/connectivity_state.dart';
import 'package:flutter_btmnavbar/mixins/snackbar.dart';
import 'package:flutter_btmnavbar/providers/bloc_providers.dart';
import 'package:flutter_btmnavbar/providers/manager_providers.dart';
import 'package:flutter_btmnavbar/providers/service_providers.dart';
import 'package:flutter_btmnavbar/styles/color.dart';
import 'package:flutter_btmnavbar/views/main_view.dart';
import 'package:flutter_btmnavbar/views/pages/login_view.dart';
import 'package:flutter_btmnavbar/widgets/loadings/circular_progress_indicator_view.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        ...ManagerProviders().providers,
        ...ServiceProviders().providers,
      ],
      child: MultiBlocProvider(
        providers: BlocProviders().providers,
        child: App(),
      ),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with MySnackBar {
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
        home: _buildRoot(context),
      ),
    );
  }

  Widget _buildRoot(BuildContext context) => BlocListener<ConnectivityBloc, ConnectivityState>(
        listener: (context, state) {
          if (state is ConnectivityOfflineState) {
            showError(context, 'Internet connection issue');
          }
          if (state is ConnectivityOnlineState) {
            showSuccess(context, 'Internet connection is available');
          }
        },
        child: BlocBuilder<ConfigBloc, ConfigState>(
          builder: (context, configState) {
            if (configState is ConfigLoadedState) {
              return BlocBuilder<AuthBloc, AuthState>(
                builder: (context, authState) => _buildView(context, authState),
              );
            } else {
              return MyCircularProgressIndicatorView();
            }
          },
        ),
      );

  Widget _buildView(BuildContext context, AuthState state) => state is AuthAuthenticatedState ? MainView() : LoginView();
}
