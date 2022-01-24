import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_btmnavbar/views/pages/bookmark_view.dart';
import 'package:flutter_btmnavbar/views/pages/home_view.dart';
import 'package:flutter_btmnavbar/views/pages/search_view.dart';
import 'package:flutter_btmnavbar/views/pages/settings_view.dart';
import 'package:flutter_btmnavbar/widgets/inputs/floating_action_button_widget.dart';
import 'package:flutter_btmnavbar/widgets/navigations/app_bar_widget.dart';
import 'package:flutter_btmnavbar/widgets/navigations/floating_bottom_app_bar_widget.dart';

//Main view
class MainView extends StatefulWidget {
  MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

//State<StatefulWidget> action method
class _MainViewState extends State<MainView> with SingleTickerProviderStateMixin {
  final homePageIndex = 0;
  final searchPageIndex = 1;
  final bookmarkPageIndex = 2;
  final settingsPageIndex = 3;

  late int currentPage;
  late TabController tabController;
  final List<Color> colors = [Colors.red, Colors.yellow, Colors.green, Colors.blue, Colors.pink];
  final List<Widget> navItems = [
    HomeView(),
    HomeView(),
    SearchView(),
    BookmarkView(),
    SettingsView(),
  ];

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 5, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: FloatingBottomAppBar(
              currentPage: currentPage,
              tabController: tabController,
              colors: colors,
              unselectedColor: Colors.white,
              barColor: Colors.black,
              start: 10,
              end: 2,
              child: TabBarView(
                controller: tabController,
                dragStartBehavior: DragStartBehavior.down,
                physics: const BouncingScrollPhysics(),
                children: navItems,
              ),
            ),
            // floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0 ? _buildFloatingActionButton() : null,
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked),
      );

  // MARK: private builders

  PreferredSizeWidget _buildAppBar(BuildContext context) => MyAppBar(title: "Flutter Template");

  // ignore: unused_element
  FloatingActionButtonWidget _buildFloatingActionButton(BuildContext context) => FloatingActionButtonWidget(
        onPressed: () {},
      );
}
