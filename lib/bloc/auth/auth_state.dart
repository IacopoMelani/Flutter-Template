import 'package:flutter_btmnavbar/models/user.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthNotAuthenticatedState extends AuthState {}

class AuthAuthenticatedState extends AuthState {
  final User user;

  AuthAuthenticatedState({required this.user});
}

class AuthFailureState extends AuthState {
  final String message;

  AuthFailureState({required this.message});
}
