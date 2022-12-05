import 'package:flutter/material.dart';
import 'package:radio_upp/config/brand_colors.dart';
import 'package:radio_upp/logic/cubits/radio_cubit/current_station_cubit.dart';
import 'package:radio_upp/ui/components/brand_icons/brand_icons.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    Key? key,
    required this.status,
  }) : super(key: key);

  final StationStatus status;

  @override
  Widget build(BuildContext context) {
    late IconData icon;
    late Color iconsColor;
    late Color backgroundColor;
    var isGlowing = false;
    switch (status) {
      case StationStatus.canPlay:
        icon = BrandIcons.play;
        iconsColor = BrandColors.white;
        backgroundColor = BrandColors.darkGreen;
        isGlowing = true;
        break;
      case StationStatus.canPause:
        icon = BrandIcons.pause;
        backgroundColor = BrandColors.darkGreen.withOpacity(0.1);

        iconsColor = BrandColors.darkGreen;
        break;
      case StationStatus.error:
        icon = BrandIcons.close;
        backgroundColor = BrandColors.red.withOpacity(0.1);

        iconsColor = BrandColors.red;

        break;
    }

    return Stack(
      children: [
        if (isGlowing)
          Positioned(
            bottom: 1,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: BrandColors.darkGreen.withOpacity(0.8),
                    blurRadius: 25,
                  ),
                ],
              ),
            ),
          ),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 25,
            color: iconsColor,
          ),
        ),
      ],
    );
  }
}
