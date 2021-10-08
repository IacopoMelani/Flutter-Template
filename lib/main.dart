// @author  ninan

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_btmnavbar/styles/color.dart';
import './screens/home.dart' as _firstTab;
import './screens/search.dart' as _secondTab;
import './screens/bookmark.dart' as _thirdTab;
import './screens/setting.dart' as _fourthTab;

void main() {
  runApp(MyApp());
}

//This widget is the main widget.
class MyApp extends StatelessWidget {
  static const String appTitle = 'Bottom Nav Bar';

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ColorApp.lightTheme,
      dark: ColorApp.darkTheme,
      initial: AdaptiveThemeMode.system,
      builder: (light, dark) => MaterialApp(
        title: appTitle,
        theme: light,
        darkTheme: dark,
        home: InitalScreenWidget(),
      ),
    );
  }
}

//Initial widget
class InitalScreenWidget extends StatefulWidget {
  // InitialScreenWidget({Key key}) : super(key: key);

  @override
  HomeWidget createState() => HomeWidget();
}

//State<StatefulWidget> action method
class HomeWidget extends State<InitalScreenWidget> {
  final homePageIndex = 0;
  final searchPageIndex = 1;
  final bookmarkPageIndex = 2;
  final settingsPageIndex = 3;

  final double iconSize = 30;

  int _currentPage = 0;

  //Page controller
  PageController _navPage = PageController(initialPage: 0);

  final List<Widget> navItems = [
    new _firstTab.Home(),
    new _secondTab.Search(),
    new _thirdTab.Bookmark(),
    new _fourthTab.Settings(),
  ];

  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomAppBar(),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // MARK: privates

  bool _isPagePressed({pageIndex: int}) {
    if (_currentPage == pageIndex) {
      return true;
    } else {
      return false;
    }
  }

  Color _iconColor({required BuildContext context, pageIndex: int}) =>
      _isPagePressed(pageIndex: pageIndex) ? ColorApp.iconPressed(context) : ColorApp.iconUnpressed(context);

  void _navItemClicked({pageIndex: int}) {
    setState(() {
      _currentPage = pageIndex;
      _navPage.jumpToPage(pageIndex);
    });
  }

  // MARK: private builders

  AppBar _buildAppBar() => AppBar(
        centerTitle: true,
        title: Text(
          'Bottom Nav Bar',
        ),
      );

  BottomAppBar _buildBottomAppBar() => BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 60.0,
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildNavItemsButtons(),
          ),
        ),
      );

  FloatingActionButton _buildFloatingActionButton() => FloatingActionButton(
        onPressed: () {},
        backgroundColor: ColorApp.floatingActionButtonColor(context),
        child: const Icon(
          Icons.phone,
          color: ColorApp.floatingActionButtonIconColor,
        ),
      );

  List<Widget> _buildNavItemsButtons() => [
        IconButton(
          iconSize: iconSize,
          icon: Icon(Icons.home, color: _iconColor(context: context, pageIndex: homePageIndex)),
          onPressed: () => _navItemClicked(pageIndex: homePageIndex),
        ),
        IconButton(
          iconSize: iconSize,
          icon: Icon(Icons.search, color: _iconColor(context: context, pageIndex: searchPageIndex)),
          onPressed: () => _navItemClicked(pageIndex: searchPageIndex),
        ),
        IconButton(
          iconSize: iconSize,
          icon: Icon(Icons.bookmark, color: _iconColor(context: context, pageIndex: bookmarkPageIndex)),
          onPressed: () => _navItemClicked(pageIndex: bookmarkPageIndex),
        ),
        IconButton(
          iconSize: iconSize,
          icon: Icon(Icons.settings, color: _iconColor(context: context, pageIndex: settingsPageIndex)),
          onPressed: () => _navItemClicked(pageIndex: settingsPageIndex),
        ),
      ];

  PageView _buildPageView() => PageView(
        controller: _navPage,
        children: navItems,
        physics: NeverScrollableScrollPhysics(), //to disable Swipe
      );
}
