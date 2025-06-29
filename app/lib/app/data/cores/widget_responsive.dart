import 'package:flutter/cupertino.dart';

// make font size responsive
double getResponsiveFontSize(BuildContext context, double baseSize) {
  double screenWidth = MediaQuery.of(context).size.width;
  return baseSize * (screenWidth / 375); // 375 is iPhone X width
}