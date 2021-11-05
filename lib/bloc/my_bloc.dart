import 'package:bloc/bloc.dart';
import 'package:flutter_btmnavbar/managers/config_manager.dart';
import 'package:flutter_btmnavbar/managers/connectivity_manager.dart';

abstract class MyBloc<E, S> extends Bloc<E, S> {
  MyBloc(S initialState) : super(initialState);

  /// The method [withConnectivity] is to dispatch an [E] event action to the bloc esuring that the device is connected to the internet.
  Stream<S> withConnectivity(Stream<S> Function() callback) async* {
    if ((await ConnectivityManager().isConnected())) {
      yield* callback();
    }
  }

  /// The method [withConfigLoaded] is to dispatch an [E] event action to the bloc esuring that the configuration is loaded.
  Stream<S> withConfigLoaded(Stream<S> Function() callback) async* {
    if (ConfigManager().isConfigLoaded) {
      yield* callback();
    }
  }
}
