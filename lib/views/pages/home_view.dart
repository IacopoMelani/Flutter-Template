import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_btmnavbar/bloc/post_collection/post_collection_bloc.dart';
import 'package:flutter_btmnavbar/bloc/post_collection/post_collection_event.dart';
import 'package:flutter_btmnavbar/bloc/post_collection/post_collection_state.dart';
import 'package:flutter_btmnavbar/dto/post_dto.dart';
import 'package:flutter_btmnavbar/mixins/snackbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with MySnackBar {
  @override
  Widget build(BuildContext context) {
    final postCollectionBloc = BlocProvider.of<PostCollectionBloc>(context);
    if (postCollectionBloc.state.posts.isEmpty) {
      postCollectionBloc.add(PostCollectionPullEvent());
    }
    return BlocListener<PostCollectionBloc, PostCollectionState>(
      listener: (context, state) {
        if (state is PostCollectionFailedState) {
          showError(context, "Failed pull posts");
        }
      },
      child: RefreshIndicator(
        child: CustomScrollView(
          slivers: [
            BlocBuilder<PostCollectionBloc, PostCollectionState>(
              builder: (context, state) {
                if (state.posts.length > 0) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final post = state.posts[index];
                        if (state.posts.length - 10 == index) {
                          postCollectionBloc.add(PostCollectionPullEvent());
                        }
                        return _buildPost(post);
                      },
                      childCount: state.posts.length,
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildListDelegate([]),
                );
              },
            ),
            BlocBuilder<PostCollectionBloc, PostCollectionState>(
              builder: (context, state) {
                if (state is PostCollectionLoadingState) {
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }
                return SliverToBoxAdapter();
              },
            ),
          ],
        ),
        onRefresh: () async {
          postCollectionBloc.add(PostCollectionPullEvent(withReset: true));
        },
      ),
    );
  }

  Widget _buildPost(PostDTO post) => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage("https://picsum.photos/200/300"),
                  ),
                ),
                Flexible(
                  child: Text(
                    post.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "https://picsum.photos/450/350",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.favorite_border,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.comment_rounded),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.send_rounded),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.bookmark_border),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      );
}
