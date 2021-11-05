import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_btmnavbar/widgets/navigations/app_bar_widget.dart';

class ThemeView extends StatelessWidget {
  const ThemeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: MyAppBar(title: "theme"),
          body: Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => AdaptiveTheme.of(context).setLight(),
                      child: const Text('Light'),
                    ),
                    ElevatedButton(
                      onPressed: () => AdaptiveTheme.of(context).setDark(),
                      child: const Text('Dark'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Device will uses system theme"),
                    Switch(
                      value: AdaptiveTheme.of(context).mode.isSystem,
                      onChanged: (value) =>
                          AdaptiveTheme.of(context).mode.isSystem ? AdaptiveTheme.of(context).setLight() : AdaptiveTheme.of(context).setSystem(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
