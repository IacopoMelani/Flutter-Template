import 'package:flutter_btmnavbar/dto/user_dto.dart';

abstract class UserCollectionState {
  final UserDTOs users;

  UserCollectionState({required this.users});
}

class UserCollectionInitialState extends UserCollectionState {
  UserCollectionInitialState({required UserDTOs users}) : super(users: users);
}

class UserCollectionLoadingState extends UserCollectionState {
  UserCollectionLoadingState({required UserDTOs users}) : super(users: users);
}

class UserCollectionSuccessState extends UserCollectionState {
  UserCollectionSuccessState({required UserDTOs users}) : super(users: users);
}

class UserCollectionFailedState extends UserCollectionState {
  UserCollectionFailedState({required String error, required UserDTOs users}) : super(users: users);
}
