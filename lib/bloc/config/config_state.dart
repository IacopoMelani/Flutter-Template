import 'package:flutter_btmnavbar/managers/config_manager.dart';

abstract class ConfigState {}

class ConfigInitialState extends ConfigState {}

class ConfigLoadedState extends ConfigState {
  final ConfigManager config;

  ConfigLoadedState({required this.config});
}

class ConfigLoadedFailedState extends ConfigState {
  final String error;

  ConfigLoadedFailedState({required this.error});
}
