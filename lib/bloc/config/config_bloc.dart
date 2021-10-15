import 'package:bloc/bloc.dart';
import 'package:flutter_btmnavbar/bloc/config/config_event.dart';
import 'package:flutter_btmnavbar/bloc/config/config_state.dart';
import 'package:flutter_btmnavbar/managers/config_manager.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  final ConfigManager _configManager;

  ConfigBloc(this._configManager) : super(ConfigInitialState());

  @override
  Stream<ConfigState> mapEventToState(ConfigEvent event) async* {
    if (event is ConfigNeedsLoadEvent) {
      yield* _mapConfigNeedsLoadEventToState(event);
    }
  }

  Stream<ConfigState> _mapConfigNeedsLoadEventToState(ConfigNeedsLoadEvent event) async* {
    try {
      await _configManager.loadConfig();
      yield ConfigLoadedState(config: _configManager);
    } catch (e) {
      yield ConfigLoadedFailedState(error: e.toString());
    }
  }
}
