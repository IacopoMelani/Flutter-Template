import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_btmnavbar/bloc/user_collection/user_collection_bloc.dart';
import 'package:flutter_btmnavbar/bloc/user_collection/user_collection_event.dart';
import 'package:flutter_btmnavbar/bloc/user_collection/user_collection_state.dart';
import 'package:flutter_btmnavbar/mixins/snackbar.dart';
import 'package:flutter_btmnavbar/providers/inherited_data_provider.dart';
import 'package:flutter_btmnavbar/widgets/inputs/my_text_field.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> with MySnackBar {
  @override
  Widget build(BuildContext context) {
    final userCollectionBloc = BlocProvider.of<UserCollectionBloc>(context);
    if (userCollectionBloc.state.users.isEmpty) {
      userCollectionBloc.add(UserCollectionPullEvent());
    }
    return BlocListener<UserCollectionBloc, UserCollectionState>(
      listener: (context, state) {
        if (state is UserCollectionFailedState) {
          showError(context, "Failed pull users");
        }
      },
      child: CustomScrollView(
        controller: InheritedDataProvider.of(context).scrollController,
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0.0,
            expandedHeight: 50,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 4),
                child: MyTextField(
                  labelText: "Search",
                  type: TextFieldType.search,
                  prefixIcon: Icon(Icons.search),
                  onChanged: (value) {
                    userCollectionBloc.add(UserCollectionSearchEvent(query: value));
                  },
                ),
              ),
            ),
          ),
          BlocBuilder<UserCollectionBloc, UserCollectionState>(
            builder: (context, state) {
              if (state is UserCollectionLoadingState) {
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
          BlocBuilder<UserCollectionBloc, UserCollectionState>(
            builder: (context, state) {
              if (state.users.length > 0) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final user = state.users[index];
                      return ListTile(
                        title: Text(user.name),
                        subtitle: Text(user.email),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage("https://picsum.photos/200/300"),
                        ),
                      );
                    },
                    childCount: state.users.length,
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildListDelegate([]),
              );
            },
          ),
        ],
      ),
    );
  }
}
