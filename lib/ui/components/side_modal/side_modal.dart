import 'package:flutter/material.dart';
import 'package:radio_upp/config/get_it_config.dart';
import 'package:radio_upp/logic/get_it/navigator.dart';
import 'package:radio_upp/logic/models/station.dart';

class BrandModal {
  void openModal(List<Station> list) {
    showGeneralDialog(
      context: getIt<NavigationService>().navigator.context,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (_, __, ___) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              color: Colors.white, // Dialog background
              width: 120, // Dialog width
              height: 50, // Dialog height
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('I am a small Dialog'),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SelectStations extends StatefulWidget {
  const SelectStations({super.key});

  @override
  State<SelectStations> createState() => _SelectStationsState();
}

class _SelectStationsState extends State<SelectStations> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
