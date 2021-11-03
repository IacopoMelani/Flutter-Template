abstract class UserCollectionEvent {}

class UserCollectionPullEvent extends UserCollectionEvent {}

class UserCollectionResetEvent extends UserCollectionEvent {}

class UserCollectionSearchEvent extends UserCollectionEvent {
  final String query;

  UserCollectionSearchEvent({required this.query});
}
