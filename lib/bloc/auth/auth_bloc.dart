import 'package:bloc/bloc.dart';
import 'package:flutter_btmnavbar/bloc/auth/auth_event.dart';
import 'package:flutter_btmnavbar/bloc/auth/auth_state.dart';
import 'package:flutter_btmnavbar/services/auth_services.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc(this._authService) : super(AuthInitialState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppLoadedAuthEvent) {
      yield* _mapAppLoadedAuthEventToState(event);
    }

    if (event is UserLoggedInAuthEvent) {
      yield* _mapUserLoggedInAuthEventToState(event);
    }

    if (event is UserLoggedOutAuthEvent) {
      yield* _mapUserLoggedOutAuthEventToState(event);
    }
  }

  Stream<AuthState> _mapAppLoadedAuthEventToState(AppLoadedAuthEvent event) async* {
    yield AuthLoadingState();

    try {
      await Future.delayed(Duration(milliseconds: 500));

      final currentUser = await _authService.getCurrentUser();

      if (currentUser != null) {
        yield AuthAuthenticatedState(user: currentUser);
      } else {
        yield AuthNotAuthenticatedState();
      }
    } catch (_) {
      yield AuthFailureState(message: "Errore login");
    }
  }

  Stream<AuthState> _mapUserLoggedInAuthEventToState(UserLoggedInAuthEvent event) async* {
    yield AuthAuthenticatedState(user: event.user);
  }

  Stream<AuthState> _mapUserLoggedOutAuthEventToState(UserLoggedOutAuthEvent event) async* {
    await _authService.signOut();
    yield AuthNotAuthenticatedState();
  }
}
