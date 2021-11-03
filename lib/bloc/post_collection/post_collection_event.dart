abstract class PostCollectionEvent {}

class PostCollectionPullEvent extends PostCollectionEvent {}

class PostCollectionResetEvent extends PostCollectionEvent {}

class PostCollectionSearchEvent extends PostCollectionEvent {
  final String query;

  PostCollectionSearchEvent({required this.query});
}
