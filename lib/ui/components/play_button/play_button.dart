import 'package:flutter/material.dart';
import 'package:radio_upp/config/brand_colors.dart';
import 'package:radio_upp/ui/components/brand_icons/brand_icons.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    Key? key,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          if (!isActive)
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
              color: BrandColors.darkGreen.withOpacity(
                isActive ? 0.1 : 1,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isActive ? BrandIcons.pause : BrandIcons.play,
              size: 25,
              color: isActive ? BrandColors.darkGreen : BrandColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
