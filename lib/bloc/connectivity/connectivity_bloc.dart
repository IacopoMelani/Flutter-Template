import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_btmnavbar/bloc/connectivity/connectivity_event.dart';
import 'package:flutter_btmnavbar/bloc/connectivity/connectivity_state.dart';
import 'package:flutter_btmnavbar/managers/connectivity_manager.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final ConnectivityManager _manager;

  ConnectivityBloc(this._manager) : super(ConnectivityInitialState(ConnectivityResult.none, null)) {
    _registerCallbackToConnectivityManager();
  }

  @override
  Stream<ConnectivityState> mapEventToState(ConnectivityEvent event) async* {
    if (event is ConnectivityChangedEvent) {
      yield* _mapConnectivityChangedToState(event.status);
    }
  }

  Stream<ConnectivityState> _mapConnectivityChangedToState(ConnectivityResult result) async* {
    var connected = await ConnectivityManager.isConnectedByConnectivityResult(result);
    if (connected) {
      yield ConnectivityOnlineState(result, this.state);
    } else {
      yield ConnectivityOfflineState(result, this.state);
    }
  }

  void _registerCallbackToConnectivityManager() {
    _manager.registerCallback(
      (result) => add(ConnectivityChangedEvent(result)),
    );
  }
}
