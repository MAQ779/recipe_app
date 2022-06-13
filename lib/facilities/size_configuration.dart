import 'package:flutter/widgets.dart';
/*
this file will be reference for helping of making proper size for elements in different Screens' sizes
 */
class SizeConfigure {

static double? _screenHeight;
static double? _screenWidth;
static double? widthConfig;
static double? heightConfig;
static double? textConfig;
static double? imageConfig;

void takeScreenMeasurement(BoxConstraints constraints) {
  _screenHeight = constraints.maxHeight / 100;
  _screenWidth =constraints.maxWidth / 100;
   widthConfig = _screenWidth;
  heightConfig = _screenHeight;
  textConfig = _screenHeight;
  imageConfig = _screenWidth;
}
}