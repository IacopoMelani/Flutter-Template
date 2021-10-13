import 'package:flutter_btmnavbar/exceptions/auth_exception.dart';
import 'package:flutter_btmnavbar/models/user.dart';

abstract class AuthService {
  Future<User?> getCurrentUser();
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class FakeAuthenticationService extends AuthService {
  @override
  Future<User?> getCurrentUser() async {
    return User(name: 'Test User', email: "test@domain.com");
  }

  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(Duration(seconds: 1)); // simulate a network delay

    if (email.toLowerCase() != 'test@domain.com' || password != 'testpass123') {
      throw AuthenticationException(message: 'Wrong username or password');
    }
    return User(name: 'Test User', email: email);
  }

  @override
  Future<void> signOut() async {}
}
