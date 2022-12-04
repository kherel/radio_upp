import 'package:hive_flutter/hive_flutter.dart';

class HiveConfig {
  HiveConfig._();

  static final HiveConfig _instance = HiveConfig._();

  factory HiveConfig() => _instance;

  final List<Box> openedBoxes = [];

  Future<void> init() async {
    await Hive.initFlutter();
  }

  Future<void> clearAll() async {
    var futures = openedBoxes.map((b) => b.clear()).toList();
    await Future.wait(futures);
  }
}

enum HiveContants {
  stationCountByCountry,
  stationHistory,
}
