import 'package:flutter/material.dart';
import 'package:radio_upp/ui/components/logo/logo.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacity;
  late Animation<double> zoom;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();

    var curvedAnimation = CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.8,
        0.9,
        curve: Curves.easeInExpo,
      ),
    );
    zoom = Tween<double>(
      begin: 1,
      end: 40,
    ).animate(curvedAnimation);

    opacity = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(curvedAnimation);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Transform.scale(
              scale: zoom.value,
              child: Opacity(
                opacity: opacity.value,
                child: child!,
              ),
            );
          },
          child: const Logo.big()),
    );
  }
}
