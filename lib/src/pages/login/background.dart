import 'package:flutter/material.dart';

class Background {
  const Background();

  static const Color gradientStart = const Color(0xFF373b44);
  static const Color gradientEnd = const Color(0xFF4286f4);

  static const gradient = const LinearGradient(
    colors: const [gradientStart, gradientEnd],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 1.0],
  );
}
