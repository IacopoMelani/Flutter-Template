import 'package:flutter/material.dart';

class PageViewWidget extends StatelessWidget {
  final PageController pageController;
  final List<Widget> pages;

  const PageViewWidget({
    Key? key,
    required this.pageController,
    required this.pages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => PageView(
        controller: pageController,
        children: pages,
        physics: NeverScrollableScrollPhysics(), //to disable Swipe
      );
}
