import 'package:equatable/equatable.dart';
import 'package:flutter_btmnavbar/models/user.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class AppLoadedAuthEvent extends AuthEvent {}

class UserLoggedInAuthEvent extends AuthEvent {
  final User user;

  UserLoggedInAuthEvent({required this.user});
}

class UserLoggedOutAuthEvent extends AuthEvent {}
