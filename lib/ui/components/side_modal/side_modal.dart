import 'package:flutter/material.dart';
import 'package:radio_upp/config/brand_colors.dart';
import 'package:radio_upp/config/get_it_config.dart';
import 'package:radio_upp/logic/get_it/navigator.dart';
import 'package:radio_upp/logic/models/station.dart';

class BrandModal {
  static Future<T?> openModal<T>(List<Station> list) {
    return showDialog<T>(
      context: getIt<NavigationService>().navigator.overlay!.context,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: true,
      builder: (context) => SelectStations(list: list),
      useSafeArea: false,
    );
  }
}

class SelectStations extends StatefulWidget {
  const SelectStations({
    super.key,
    required this.list,
  });
  final List<Station> list;
  @override
  State<SelectStations> createState() => _SelectStationsState();
}

class _SelectStationsState extends State<SelectStations>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> translateAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  void _afterLayout(_) {
    translateAnimation = Tween<Offset>(
      begin: Offset(MediaQuery.of(context).size.width - 80, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOutCirc,
    ));

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Material(
        color: BrandColors.darkBlue.withOpacity(0.8),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                children: const [
                  SizedBox(width: 30),
                  Text('Spain'),
                  Spacer(),
                  Text('x'),
                  SizedBox(width: 30)
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 30),
                  decoration: BoxDecoration(
                    gradient: BrandColors.greyGradient,
                    color: BrandColors.darkBlue,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 0.5, left: 0.5),
                    decoration: const BoxDecoration(
                      gradient: BrandColors.blueGradient,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(25)),
                    ),
                    child: Row(
                      children: [
                        Container(width: 50),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
