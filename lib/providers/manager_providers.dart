import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_btmnavbar/managers/config_manager.dart';

class ManagerProviders {
  static ManagerProviders _instance = ManagerProviders._internal();

  late List<RepositoryProvider> _providers;

  factory ManagerProviders() => _instance;

  ManagerProviders._internal() {
    _init();
  }

  List<RepositoryProvider> get providers => _providers;

  void _init() {
    _providers = [
      RepositoryProvider<ConfigManager>(
        create: (context) => ConfigManager(),
      ),
    ];
  }
}
