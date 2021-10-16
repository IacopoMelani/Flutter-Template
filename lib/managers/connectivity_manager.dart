import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_btmnavbar/mixins/registrable_callbacks.dart';

class ConnectivityManager with RegistrableCallbacks {
  static ConnectivityManager _instance = ConnectivityManager._internal();

  factory ConnectivityManager() {
    return _instance;
  }

  ConnectivityManager._internal() {
    Connectivity().onConnectivityChanged.listen((event) => notify(event));
  }

  static Future<bool> isConnectedByConnectivityResult(ConnectivityResult connectivityResult) async {
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.ethernet) {
      return true;
    }
    return false;
  }

  Future<bool> isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return isConnectedByConnectivityResult(connectivityResult);
  }
}
