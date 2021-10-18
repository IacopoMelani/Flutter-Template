import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';

typedef YamlMap = Map<String, dynamic>;

class ConfigManager {
  static const String configFilePath = "assets/config.yaml";
  static ConfigManager _singleton = ConfigManager._internal();

  dynamic _config;

  factory ConfigManager() {
    return _singleton;
  }

  ConfigManager._internal();

  Future<void> loadConfig() async {
    if (_config == null) {
      var value = await rootBundle.loadString(configFilePath);
      _config = loadYaml(value);
    }
  }

  dynamic get defaultConfig => {
        "version": "0.0.0",
        "api": {},
      };

  dynamic get config => _config ?? defaultConfig;

  String get version => config['version'] ?? "";

  String get apiSchema => config["api"]["schema"] ?? "";
  String get apiHost => config["api"]["host"] ?? "";
  int get apiPort => config["api"]["port"] ?? 0;
}
