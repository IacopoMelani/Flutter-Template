import 'package:flutter/material.dart';
import 'package:flutter_btmnavbar/styles/color.dart';
import 'package:flutter_btmnavbar/views/pages/bookmark_view.dart';
import 'package:flutter_btmnavbar/views/pages/home_view.dart';
import 'package:flutter_btmnavbar/views/pages/search_view.dart';
import 'package:flutter_btmnavbar/views/pages/settings_view.dart';
import 'package:flutter_btmnavbar/widgets/inputs/floating_action_button_widget.dart';
import 'package:flutter_btmnavbar/widgets/navigations/app_bar_widget.dart';
import 'package:flutter_btmnavbar/widgets/navigations/bottom_app_bar_widget.dart';
import 'package:flutter_btmnavbar/widgets/navigations/page_view_widget.dart';

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
    HomeView(),
    SearchView(),
    BookmarkView(),
    SettingsView(),
  ];

  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: _buildPageView(context),
            bottomNavigationBar: _buildBottomAppBar(context),
            // floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0 ? _buildFloatingActionButton() : null,
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked),
      );

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

  PreferredSizeWidget _buildAppBar(BuildContext context) => MyAppBar(title: "Flutter Template");

  MyBottomAppBar _buildBottomAppBar(BuildContext context) => MyBottomAppBar(items: _buildNavItemsButtons(context));

  // ignore: unused_element
  FloatingActionButtonWidget _buildFloatingActionButton(BuildContext context) => FloatingActionButtonWidget(
        onPressed: () {},
      );

  List<Widget> _buildNavItemsButtons(BuildContext context) => [
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

  PageViewWidget _buildPageView(BuildContext context) => PageViewWidget(
        pageController: _navPage,
        pages: navItems,
      );
}
