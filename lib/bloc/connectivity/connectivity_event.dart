import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityEvent {
  final ConnectivityResult status;

  ConnectivityEvent(this.status);
}

class ConnectivityChangedEvent extends ConnectivityEvent {
  ConnectivityChangedEvent(ConnectivityResult connectivityResult) : super(connectivityResult);
}
