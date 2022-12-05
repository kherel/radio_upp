import 'package:flutter/material.dart';

class BrandColors {
  static const Color primaryBlack = Color(0xFF070B11);
  static const Color secondaryBlack = Color(0xFF1F212C);
  static const Color darkBlue = Color(0xFF070B11);
  static const Color darkGreen = Color(0xFF5BE0C8);
  static const Color middleGreen = Color(0xFFD6FFF8);

  static const Color lightGreen = Color(0xFFE6FEFA);

  static const Color red = Color(0xFFFD0707);

  static const Color blue = Color(0xFF2F8396);
  static const Color darkGrey = Color(0xFF455060);
  static const Color lightGrey = Color(0xFF9FA6B0);

  static const Color white = Colors.white;

  static const blackGradient = LinearGradient(
    begin: Alignment(0.3, -1),
    end: Alignment.bottomCenter,
    colors: [Color(0xFF2D3139), Color(0xFF1F222A)],
  );

  static const blueGradient = LinearGradient(
    begin: Alignment(0.1, -0.9),
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF2D3139),
      Color(0xFF1F222A),
    ],
  );

  static final greyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xFF595A61),
      const Color(0xFF595A61).withOpacity(0),
    ],
  );
}
