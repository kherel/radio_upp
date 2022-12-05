import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:radio_upp/config/brand_colors.dart';
import 'package:radio_upp/config/theme_typo.dart';
import 'package:radio_upp/utils/named_font_weight.dart';

class BrandTitle extends StatelessWidget {
  const BrandTitle({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      margin: const EdgeInsets.only(left: 30),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Text(
              text.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: bossa,
                fontWeight: NamedWeight.black,
                fontSize: 42,
                height: 1.35,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 0.5
                  ..shader = ui.Gradient.linear(
                    const Offset(0, 0),
                    const Offset(300, 0),
                    [
                      BrandColors.darkGreen.withOpacity(0.35),
                      BrandColors.darkGreen.withOpacity(0),
                    ],
                  ),
              ),
            ),
          ),
          Positioned(
            bottom: 6,
            child: Text(
              text.toUpperCase(),
              style: ThemeTypo.h2,
            ),
          ),
        ],
      ),
    );
  }
}
