import 'package:flutter_btmnavbar/bloc/my_bloc.dart';
import 'package:flutter_btmnavbar/bloc/post_collection/post_collection_event.dart';
import 'package:flutter_btmnavbar/bloc/post_collection/post_collection_state.dart';
import 'package:flutter_btmnavbar/dto/post_dto.dart';
import 'package:flutter_btmnavbar/services/fake_services.dart';

class PostCollectionBloc extends MyBloc<PostCollectionEvent, PostCollectionState> {
  final FakeService _service;

  PostCollectionBloc(this._service) : super(PostCollectionInitialState(posts: []));

  @override
  Stream<PostCollectionState> mapEventToState(PostCollectionEvent event) async* {
    if (event is PostCollectionPullEvent) {
      yield* _mapPostCollectionPullEventToState(event);
    }

    if (event is PostCollectionResetEvent) {
      yield* _mapPostCollectionResetEventToState(event);
    }

    if (event is PostCollectionSearchEvent) {
      yield* _mapPostCollectionSearchEventToState(event);
    }
  }

  Stream<PostCollectionState> _pullPostsAndCallback(PostCollectionEvent event, List<PostDTO> Function(List<PostDTO>)? callback) async* {
    try {
      final result = await _service.posts();
      if (result.err != null) {
        yield PostCollectionFailedState(error: result.err!.message, posts: this.state.posts);
      } else {
        if (callback != null) {
          final posts = callback(result.data!);
          yield PostCollectionSuccessState(posts: [...this.state.posts, ...posts]);
        } else {
          yield PostCollectionSuccessState(posts: [...this.state.posts, ...result.data!]);
        }
      }
    } catch (e) {
      yield PostCollectionFailedState(error: e.toString(), posts: this.state.posts);
    }
  }

  // MARK: events mapper

  Stream<PostCollectionState> _mapPostCollectionPullEventToState(PostCollectionPullEvent event) async* {
    yield* withConnectivity(() async* {
      if (event.withReset) {
        yield PostCollectionLoadingState(posts: []);
      } else {
        yield PostCollectionLoadingState(posts: this.state.posts);
      }
      yield* _pullPostsAndCallback(event, null);
    });
  }

  Stream<PostCollectionState> _mapPostCollectionResetEventToState(PostCollectionResetEvent event) async* {
    yield PostCollectionLoadingState(posts: this.state.posts);
    yield PostCollectionInitialState(posts: []);
  }

  Stream<PostCollectionState> _mapPostCollectionSearchEventToState(PostCollectionSearchEvent event) async* {
    withConnectivity(() async* {
      yield PostCollectionLoadingState(posts: this.state.posts);
      yield* _pullPostsAndCallback(event, (List<PostDTO> posts) {
        return posts.where((post) => post.title.toLowerCase().contains(event.query.toLowerCase())).toList();
      });
    });
  }
}
