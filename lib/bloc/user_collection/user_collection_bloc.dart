import 'package:bloc/bloc.dart';
import 'package:flutter_btmnavbar/bloc/user_collection/user_collection_event.dart';
import 'package:flutter_btmnavbar/bloc/user_collection/user_collection_state.dart';
import 'package:flutter_btmnavbar/dto/user_dto.dart';
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

    if (event is UserCollectionSearchEvent) {
      yield* _mapUserCollectionSearchEventToState(event);
    }
  }

  Stream<UserCollectionState> _pullUsersAndCallback(UserCollectionEvent event, List<UserDTO> Function(List<UserDTO>)? callback) async* {
    try {
      final result = await _service.users();
      if (result.err != null) {
        yield UserCollectionFailedState(error: result.err!.message, users: this.state.users);
      } else {
        if (callback != null) {
          final users = callback(result.data!);
          yield UserCollectionSuccessState(users: users);
        } else {
          yield UserCollectionSuccessState(users: result.data!);
        }
      }
    } catch (e) {
      yield UserCollectionFailedState(error: e.toString(), users: this.state.users);
    }
  }

  // MARK: events mapper

  Stream<UserCollectionState> _mapUserCollectionPullEventToState(UserCollectionPullEvent event) async* {
    yield UserCollectionLoadingState(users: this.state.users);
    yield* _pullUsersAndCallback(event, null);
  }

  Stream<UserCollectionState> _mapUserCollectionResetEventToState(UserCollectionResetEvent event) async* {
    yield UserCollectionLoadingState(users: this.state.users);
    yield UserCollectionInitialState(users: []);
  }

  Stream<UserCollectionState> _mapUserCollectionSearchEventToState(UserCollectionSearchEvent event) async* {
    yield UserCollectionLoadingState(users: this.state.users);
    yield* _pullUsersAndCallback(event, (List<UserDTO> users) {
      return users.where((user) => user.name.toLowerCase().contains(event.query.toLowerCase())).toList();
    });
  }
}
