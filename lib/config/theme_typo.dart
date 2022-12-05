import 'package:flutter/material.dart';
import 'package:radio_upp/config/brand_colors.dart';
import 'package:radio_upp/utils/named_font_weight.dart';

const bossa = 'Bossa';
const gilroy = 'Gilroy';

class ThemeTypo {
  static const h2 = TextStyle(
    fontFamily: bossa,
    fontWeight: NamedWeight.black,
    fontSize: 24,
    height: 32.4 / 24,
    color: BrandColors.white,
  );

  static const small = TextStyle(
    fontFamily: gilroy,
    fontWeight: NamedWeight.bold,
    fontSize: 13,
    height: 15.72 / 13,
    letterSpacing: 1.3,
    color: BrandColors.white,
  );

  static const regular = TextStyle(
    fontFamily: gilroy,
    fontWeight: NamedWeight.medium,
    fontSize: 16,
    height: 18.83 / 16,
    letterSpacing: 1.3,
    color: BrandColors.grey,
  );

  static const basis = TextStyle(
    fontFamily: gilroy,
    fontWeight: NamedWeight.bold,
    fontSize: 15,
    height: 19 / 15,
    color: BrandColors.white,
  );
}
