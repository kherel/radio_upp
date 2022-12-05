import 'package:flutter/material.dart';
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

class _SelectStationsState extends State<SelectStations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Center(
          child: Container(
            color: Colors.white, // Dialog background
            width: 120, // Dialog width
            height: 50, // Dialog height
            child: const Text('I am a small Dialog'),
          ),
        ),
      ),
    );
  }
}
