import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityState {
  final ConnectivityResult connectivityResult;
  final ConnectivityState? previousState;

  ConnectivityState(this.connectivityResult, this.previousState);
}

class ConnectivityInitialState extends ConnectivityState {
  ConnectivityInitialState(ConnectivityResult connectivityResult, ConnectivityState? previousState) : super(connectivityResult, previousState);
}

class ConnectivityOnlineState extends ConnectivityState {
  ConnectivityOnlineState(ConnectivityResult connectivityResult, ConnectivityState? previousState) : super(connectivityResult, previousState);
}

class ConnectivityOfflineState extends ConnectivityState {
  ConnectivityOfflineState(ConnectivityResult connectivityResult, ConnectivityState? previousState) : super(connectivityResult, previousState);
}
