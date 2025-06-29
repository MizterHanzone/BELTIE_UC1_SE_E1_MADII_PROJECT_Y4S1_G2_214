import 'package:flutter/material.dart';

class OneHubColor {
  static const Color orane = Color(0xFFFFA31A);
  static const Color black = Color(0xFF000000);
  static const Color blackGrey = Color(0xFFA4A4A4);
  static const Color white = Color(0xFFFFFFFF);

  static const LinearGradient linear = LinearGradient(
    colors: [orane, white],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient linear1 = LinearGradient(
    colors: [white, orane],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

// 0xFF
// #FFA31A