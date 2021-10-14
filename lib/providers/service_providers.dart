import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_btmnavbar/services/auth_services.dart';

class ServiceProviders {
  static ServiceProviders _instance = ServiceProviders._internal();

  late List<RepositoryProvider> _providers;

  factory ServiceProviders() {
    return _instance;
  }

  ServiceProviders._internal() {
    _init();
  }

  List<RepositoryProvider> get providers => _providers;

  void _init() {
    _providers = [
      RepositoryProvider<AuthService>(
        create: (context) => FakeAuthenticationService(),
      ),
    ];
  }
}
