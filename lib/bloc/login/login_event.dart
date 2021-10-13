abstract class LoginEvent {}

class LoginWithEmailButtonPressedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginWithEmailButtonPressedEvent({required this.email, required this.password});
}
