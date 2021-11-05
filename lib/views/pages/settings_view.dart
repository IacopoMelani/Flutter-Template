import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_btmnavbar/bloc/logout/logout_bloc.dart';
import 'package:flutter_btmnavbar/bloc/logout/logout_event.dart';
import 'package:flutter_btmnavbar/bloc/logout/logout_state.dart';
import 'package:flutter_btmnavbar/styles/color.dart';
import 'package:flutter_btmnavbar/views/settings/theme_view.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late List<ListItem> _items = [
    HeadingItem('Settings'),
    MessageItem('Theme', ColorApp.isDarkMode(context) ? CupertinoIcons.sun_max_fill : CupertinoIcons.moon_fill, _pushThemeView),
    HeadingItem('Other'),
    MessageItem('Logout', Icons.exit_to_app, _logout),
  ];

  @override
  Widget build(BuildContext context) => new Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            final item = _items[index];
            return ListTile(
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

  foffo() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => setState(
                  () => AdaptiveTheme.of(context).toggleThemeMode(),
                ),
                child: Text('Toggle theme'),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Theme mode: '),
              Text(AdaptiveTheme.of(context).mode.name),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<LogoutBloc, LogoutState>(
                builder: (context, state) => ElevatedButton(
                  onPressed: state is LogoutLoadingState ? null : _logout,
                  child: Text('Logout'),
                ),
              )
            ],
          ),
        ],
      );
}

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final IconData icon;
  final void Function()? onTap;

  MessageItem(this.sender, this.icon, this.onTap);

  @override
  Widget buildTitle(BuildContext context) => GestureDetector(
        onTap: this.onTap,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Icon(icon),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(sender),
            ),
          ],
        ),
      );
}
