import 'package:bloc/bloc.dart';
import 'package:flutter_btmnavbar/bloc/auth/auth_bloc.dart';
import 'package:flutter_btmnavbar/bloc/login/login_event.dart';
import 'package:flutter_btmnavbar/bloc/login/login_state.dart';
import 'package:flutter_btmnavbar/exceptions/auth_exception.dart';
import 'package:flutter_btmnavbar/services/auth_services.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthBloc _authBloc;
  final AuthService _authService;

  LoginBloc(this._authBloc, this._authService) : super(LoginInitialState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithEmailButtonPressedEvent) {
      yield* _mapLoginWithEmailButtonPressedEventToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithEmailButtonPressedEventToState(LoginWithEmailButtonPressedEvent event) async* {
    yield LoginLoadingState();

    try {
      final user = await _authService.signInWithEmailAndPassword(event.email, event.password);
      if (user != null) {
        yield LoginSuccessState();
        yield LoginInitialState();
      } else {
        yield LoginFailureState(error: "Login non riuscito");
      }
    } on AuthenticationException catch (e) {
      yield LoginFailureState(error: e.message);
    } catch (e) {
      yield LoginFailureState(error: e.toString());
    }
  }
}
