import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_btmnavbar/bloc/auth/auth_bloc.dart';
import 'package:flutter_btmnavbar/bloc/auth/auth_event.dart';
import 'package:flutter_btmnavbar/bloc/config/config_bloc.dart';
import 'package:flutter_btmnavbar/bloc/config/config_event.dart';
import 'package:flutter_btmnavbar/bloc/login/login_bloc.dart';
import 'package:flutter_btmnavbar/bloc/logout/logout_bloc.dart';
import 'package:flutter_btmnavbar/managers/config_manager.dart';
import 'package:flutter_btmnavbar/services/auth_services.dart';

class BlocProviders {
  static final BlocProviders _instance = new BlocProviders._internal();

  late List<BlocProvider<Bloc>> _providers;

  BlocProviders._internal() {
    _init();
  }

  factory BlocProviders() {
    return _instance;
  }

  List<BlocProvider<Bloc>> get providers => _providers;

  void _init() {
    _providers = [
      // ConfigBloc
      BlocProvider<ConfigBloc>(
        create: (context) => ConfigBloc(
          RepositoryProvider.of<ConfigManager>(context),
        )..add(
            ConfigNeedsLoadEvent(),
          ),
      ),
      // AuthBloc
      BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(RepositoryProvider.of<AuthService>(context))
          ..add(
            AppLoadedAuthEvent(),
          ),
      ),
      // LoginBloc
      BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          BlocProvider.of<AuthBloc>(context),
          RepositoryProvider.of<AuthService>(context),
        ),
      ),
      // LogoutBloc
      BlocProvider<LogoutBloc>(
        create: (context) => LogoutBloc(
          BlocProvider.of<AuthBloc>(context),
          RepositoryProvider.of<AuthService>(context),
        ),
      ),
    ];
  }
}
