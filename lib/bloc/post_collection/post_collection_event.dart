abstract class PostCollectionEvent {}

class PostCollectionPullEvent extends PostCollectionEvent {
  final bool withReset;

  PostCollectionPullEvent({this.withReset = false});
}

class PostCollectionResetEvent extends PostCollectionEvent {}

class PostCollectionSearchEvent extends PostCollectionEvent {
  final String query;

  PostCollectionSearchEvent({required this.query});
}
