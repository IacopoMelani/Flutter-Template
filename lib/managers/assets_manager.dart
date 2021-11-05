import 'package:flutter/widgets.dart';

class AssetsManager {
  static const String _kAssetsPath = 'assets';
  static const String _kImagesPath = 'images';
  static const String _kLogoPath = 'logo';

  static const String _kSpashPath = 'splash';

  static const _kLogoFilename = 'logo.png';
  static const _kSplashFilename = 'splash_lottie.json';

  static AssetsManager _instance = AssetsManager._internal();

  factory AssetsManager() {
    return _instance;
  }

  AssetsManager._internal();

  Image get logo => Image.asset(_logoAssetPath);
  String get splash => _splashAssetPath;

  String get _logoAssetPath => _kAssetsPath + '/' + _kImagesPath + '/' + _kLogoPath + '/' + _kLogoFilename;
  String get _splashAssetPath => _kAssetsPath + '/' + _kSpashPath + '/' + _kSplashFilename;
}
