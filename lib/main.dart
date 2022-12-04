import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:radio_upp/app.dart';
import 'package:radio_upp/config/brand_theme.dart';
import 'package:radio_upp/config/get_it_config.dart';
import 'package:radio_upp/config/hive_config.dart';
import 'package:radio_upp/logic/get_it/navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await HiveConfig().init();
  getItSetup();
  runApp(const _Main());
}

class _Main extends StatelessWidget {
  const _Main();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: getIt.get<NavigationService>().navigatorKey,
      title: 'RadioUpp',
      theme: brandTheme,
      debugShowCheckedModeBanner: false,
      home: const App(),
    );
  }
}
