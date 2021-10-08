import 'package:flutter/material.dart';
import 'package:flutter_btmnavbar/styles/color.dart';
import 'package:flutter_btmnavbar/widgets/inputs/floating_action_button_widget.dart';
import 'package:flutter_btmnavbar/widgets/navigations/bottom_app_bar_widget.dart';
import 'package:flutter_btmnavbar/widgets/navigations/page_view_widget.dart';

import 'pages/home_view.dart' as homeView;
import 'pages/search_view.dart' as _searchView;
import 'pages/bookmark_view.dart' as bookmarkView;
import 'pages/setting_view.dart' as SettingsView;

//Main view
class MainView extends StatefulWidget {
  MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

//State<StatefulWidget> action method
class _MainViewState extends State<MainView> {
  final homePageIndex = 0;
  final searchPageIndex = 1;
  final bookmarkPageIndex = 2;
  final settingsPageIndex = 3;

  final double iconSize = 30;

  int _currentPage = 0;

  //Page controller
  PageController _navPage = PageController(initialPage: 0);

  final List<Widget> navItems = [
    new homeView.Home(),
    new _searchView.Search(),
    new bookmarkView.Bookmark(),
    new SettingsView.Settings(),
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

  BottomAppBarWidget _buildBottomAppBar() => BottomAppBarWidget(items: _buildNavItemsButtons());

  FloatingActionButtonWidget _buildFloatingActionButton() => FloatingActionButtonWidget(
        onPressed: () {},
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

  PageViewWidget _buildPageView() => PageViewWidget(
        pageController: _navPage,
        pages: navItems,
      );
}
