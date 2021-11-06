import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_btmnavbar/bloc/logout/logout_bloc.dart';
import 'package:flutter_btmnavbar/bloc/logout/logout_event.dart';
import 'package:flutter_btmnavbar/bloc/logout/logout_state.dart';
import 'package:flutter_btmnavbar/styles/color.dart';
import 'package:flutter_btmnavbar/views/settings/theme_view.dart';
import 'package:flutter_btmnavbar/widgets/list/list_item_builder.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late List<ListItem> _items = [
    HeadingItem(title: 'Settings'),
    MessageItem(title: 'Theme', icon: ColorApp.isDarkMode(context) ? CupertinoIcons.sun_max_fill : CupertinoIcons.moon_fill, onTap: _pushThemeView),
    HeadingItem(title: 'Other'),
    MessageItem(title: 'Logout', icon: Icons.exit_to_app, onTap: _logout),
  ];

  @override
  Widget build(BuildContext context) => new Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            final item = _items[index];
            return ListTile(
              dense: true,
              onTap: item.onTapHandler(),
              title: item.buildTitle(context),
            );
          },
          itemCount: _items.length,
        ),
      );

  void _logout() async {
    final state = BlocProvider.of<LogoutBloc>(context).state;
    if (state is LogoutLoadingState) {
      return;
    }
    final logoutBloc = BlocProvider.of<LogoutBloc>(context);
    logoutBloc.add(LogoutPressedEvent());
  }

  void _pushThemeView() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ThemeView(),
      ),
    );
  }
}
