import 'dart:async';

import 'package:flutter/material.dart';
import 'package:radio_upp/ui/pages/dashboard/dashboard.dart';
import 'package:radio_upp/ui/pages/splash/splash.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool hasSplashScreen = true;

  @override
  void initState() {
    super.initState();
    timer = Timer(
      const Duration(seconds: 3),
      () => setState(() => hasSplashScreen = false),
    );
  }

  late Timer timer;

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (hasSplashScreen) {
      return const Splash();
    }
    return const Dashboard();
  }
}
