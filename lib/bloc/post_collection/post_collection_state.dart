import 'package:flutter_btmnavbar/dto/post_dto.dart';

abstract class PostCollectionState {
  final PostDTOs posts;

  PostCollectionState({required this.posts});
}

class PostCollectionInitialState extends PostCollectionState {
  PostCollectionInitialState({required PostDTOs posts}) : super(posts: posts);
}

class PostCollectionLoadingState extends PostCollectionState {
  PostCollectionLoadingState({required PostDTOs posts}) : super(posts: posts);
}

class PostCollectionSuccessState extends PostCollectionState {
  PostCollectionSuccessState({required PostDTOs posts}) : super(posts: posts);
}

class PostCollectionFailedState extends PostCollectionState {
  PostCollectionFailedState({required String error, required PostDTOs users}) : super(posts: users);
}
