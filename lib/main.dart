import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:radio_upp/app.dart';
import 'package:radio_upp/config/bloc_config.dart';
import 'package:radio_upp/config/brand_theme.dart';
import 'package:radio_upp/config/get_it_config.dart';
import 'package:radio_upp/config/hive_config.dart';
import 'package:radio_upp/logic/get_it/navigator.dart';
import 'package:radio_upp/ui/components/brand_system_overlay/brand_system_overlay.dart';

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
    return BlocAndProviderConfig(
      child: BrandSystemOverlay(
        isFontBlack: false,
        child: MaterialApp(
          navigatorKey: getIt.get<NavigationService>().navigatorKey,
          title: 'RadioUpp',
          theme: brandTheme,
          debugShowCheckedModeBanner: false,
          home: const App(),
        ),
      ),
    );
  }
}
