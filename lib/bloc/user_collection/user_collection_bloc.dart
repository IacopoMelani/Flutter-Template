import 'package:bloc/bloc.dart';
import 'package:flutter_btmnavbar/bloc/user_collection/user_collection_event.dart';
import 'package:flutter_btmnavbar/bloc/user_collection/user_collection_state.dart';
import 'package:flutter_btmnavbar/services/fake_services.dart';

class UserCollectionBloc extends Bloc<UserCollectionEvent, UserCollectionState> {
  final FakeService _service;

  UserCollectionBloc(this._service) : super(UserCollectionInitialState(users: []));

  @override
  Stream<UserCollectionState> mapEventToState(UserCollectionEvent event) async* {
    if (event is UserCollectionPullEvent) {
      yield* _mapUserCollectionPullEventToState(event);
    }

    if (event is UserCollectionResetEvent) {
      yield* _mapUserCollectionResetEventToState(event);
    }
  }

  Stream<UserCollectionState> _mapUserCollectionPullEventToState(UserCollectionPullEvent event) async* {
    yield UserCollectionLoadingState(users: this.state.users);
    try {
      final result = await _service.users();
      if (result.err != null) {
        yield UserCollectionFailedState(error: result.err!.message, users: this.state.users);
      } else {
        yield UserCollectionSuccessState(users: result.data!);
        yield UserCollectionInitialState(users: result.data!);
      }
    } catch (e) {
      UserCollectionFailedState(error: e.toString(), users: this.state.users);
    }
  }

  Stream<UserCollectionState> _mapUserCollectionResetEventToState(UserCollectionResetEvent event) async* {
    yield UserCollectionLoadingState(users: this.state.users);
    yield UserCollectionInitialState(users: []);
  }
}
