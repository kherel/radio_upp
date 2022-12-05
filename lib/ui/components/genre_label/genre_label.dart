import 'package:flutter/material.dart';
import 'package:radio_upp/config/brand_colors.dart';
import 'package:radio_upp/config/theme_typo.dart';
import 'package:radio_upp/logic/models/genre.dart';

class GenreLabel extends StatelessWidget {
  const GenreLabel({
    super.key,
    required this.genre,
  });

  final Genre genre;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      decoration: BoxDecoration(
          color: BrandColors.darkGreen.withOpacity(0.1),
          borderRadius: BorderRadius.circular(50)),
      child: Text(
        genre.name,
        style:
            ThemeTypo.small.copyWith(color: BrandColors.darkGreen, height: 1.2),
      ),
    );
  }
}
