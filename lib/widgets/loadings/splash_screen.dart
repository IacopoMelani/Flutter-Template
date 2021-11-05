import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_btmnavbar/managers/assets_manager.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  final Widget viewOnLoad;

  const SplashScreen({Key? key, required this.viewOnLoad}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AssetsManager _assetsManager;

  @override
  void initState() {
    super.initState();
    _assetsManager = RepositoryProvider.of<AssetsManager>(context);
    _controller = AnimationController(
      duration: Duration(
        seconds: (5),
      ),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Lottie.asset(
          _assetsManager.splash,
          controller: _controller,
          height: MediaQuery.of(context).size.height * 1,
          animate: true,
          onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              ..forward().whenComplete(
                () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => widget.viewOnLoad),
                ),
              );
          },
        ),
      );
}
