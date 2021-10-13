import 'package:bloc/bloc.dart';
import 'package:flutter_btmnavbar/bloc/auth/auth_bloc.dart';
import 'package:flutter_btmnavbar/bloc/auth/auth_event.dart';
import 'package:flutter_btmnavbar/bloc/logout/logout_event.dart';
import 'package:flutter_btmnavbar/bloc/logout/logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthBloc _authBloc;

  LogoutBloc(this._authBloc) : super(LogoutInitialState());

  @override
  Stream<LogoutState> mapEventToState(LogoutEvent event) async* {
    if (event is LogoutPressedEvent) {
      yield* _mapLogoutPressedEventToState(event);
    }
  }

  Stream<LogoutState> _mapLogoutPressedEventToState(LogoutPressedEvent event) async* {
    yield LogoutLoadingState();
    _authBloc.add(UserLoggedOutAuthEvent());
    yield LogoutSuccessState();
    yield LogoutInitialState();
  }
}
