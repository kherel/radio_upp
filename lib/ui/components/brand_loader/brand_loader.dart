import 'package:flutter/material.dart';
import 'package:radio_upp/config/brand_colors.dart';
import 'package:radio_upp/ui/components/brand_icons/brand_icons.dart';
import 'package:shimmer/shimmer.dart';

class BrandLoader extends StatelessWidget {
  const BrandLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: BrandColors.darkGreen,
      highlightColor: BrandColors.lightGreen,
      child: const Icon(
        BrandIcons.flash,
        size: 30,
      ),
    );
  }
}
