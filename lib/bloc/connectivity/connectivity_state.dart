import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityState {
  final ConnectivityResult connectivityResult;

  ConnectivityState(this.connectivityResult);
}

class ConnectivityInitialState extends ConnectivityState {
  ConnectivityInitialState(connectivityResult) : super(connectivityResult);
}

class ConnectivityOnlineState extends ConnectivityState {
  ConnectivityOnlineState(connectivityResult) : super(connectivityResult);
}

class ConnectivityOfflineState extends ConnectivityState {
  ConnectivityOfflineState(connectivityResult) : super(connectivityResult);
}
