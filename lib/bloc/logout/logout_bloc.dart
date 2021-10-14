import 'package:bloc/bloc.dart';
import 'package:flutter_btmnavbar/bloc/auth/auth_bloc.dart';
import 'package:flutter_btmnavbar/bloc/auth/auth_event.dart';
import 'package:flutter_btmnavbar/bloc/logout/logout_event.dart';
import 'package:flutter_btmnavbar/bloc/logout/logout_state.dart';
import 'package:flutter_btmnavbar/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthBloc _authBloc;
  final AuthService _authService;

  LogoutBloc(this._authBloc, this._authService) : super(LogoutInitialState());

  @override
  Stream<LogoutState> mapEventToState(LogoutEvent event) async* {
    if (event is LogoutPressedEvent) {
      yield* _mapLogoutPressedEventToState(event);
    }
  }

  Stream<LogoutState> _mapLogoutPressedEventToState(LogoutPressedEvent event) async* {
    yield LogoutLoadingState();
    await _authService.signOut();
    (await SharedPreferences.getInstance()).setBool("isLoggedIn", false);
    _authBloc.add(UserLoggedOutAuthEvent());
    yield LogoutSuccessState();
    yield LogoutInitialState();
  }
}
