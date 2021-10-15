import 'package:flutter_btmnavbar/exceptions/auth_exception.dart';
import 'package:flutter_btmnavbar/models/user.dart';
import 'package:flutter_btmnavbar/services/_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthService extends HttpService {
  Future<User?> getCurrentUser();
  Future<bool> isLoggedIn();
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

const FAKE_USER_EMAIL = "test@domain.com";
const FAKE_USER_PASSWORD = "123456";

class FakeAuthenticationService extends AuthService {
  @override
  String get host => "";

  @override
  int get port => 0;

  @override
  String get schema => "";

  @override
  Future<User?> getCurrentUser() async {
    if ((await isLoggedIn())) {
      return User(name: "Test User", email: FAKE_USER_EMAIL);
    }
    return null;
  }

  @override
  Future<bool> isLoggedIn() async {
    return (await SharedPreferences.getInstance()).getBool("isLoggedIn") ?? false;
  }

  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(Duration(seconds: 1));

    if (email.toLowerCase() != FAKE_USER_EMAIL || password != FAKE_USER_PASSWORD) {
      throw AuthenticationException(message: 'Email o password errati');
    }
    return User(name: 'Test User', email: email);
  }

  @override
  Future<void> signOut() async {}
}
