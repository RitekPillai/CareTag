import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQuery;
  static late double screenWidth;
  static late double screenHeight;

  static const double figmaCanvasHeight = 393.0;
  static const double figmaCanvasWidth = 852.0;

  void init(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    screenWidth = _mediaQuery.size.width;
    screenHeight = _mediaQuery.size.height;
  }

  static double w(double pixels) {
    return (pixels / figmaCanvasWidth) * screenWidth;
  }

  static double h(double pixels) {
    return (pixels / figmaCanvasHeight) * screenHeight;
  }

  static double sp(double fontSize) {
    return (fontSize / figmaCanvasWidth) * screenWidth;
  }

  static double r(double radius) {
    return (radius / figmaCanvasWidth) * screenWidth;
  }
}
