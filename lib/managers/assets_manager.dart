import 'package:flutter/widgets.dart';

class AssetsManager {
  static const String _kAssetsPath = 'assets';
  static const String _kImagesPath = 'images';
  static const String _kLogoPath = 'logo';

  static const _kLogoFilename = 'logo.png';

  static AssetsManager _instance = AssetsManager._internal();

  factory AssetsManager() {
    return _instance;
  }

  AssetsManager._internal();

  Image get logo => Image.asset(_logoPath);

  get _logoPath => _kAssetsPath + '/' + _kImagesPath + '/' + _kLogoPath + '/' + _kLogoFilename;
}
