import 'package:flutter/material.dart';
import '../../facilities/size_configuration.dart';

Widget loaderPart(double height, double width, Color color) {
  return Container(
    height: SizeConfigure.widthConfig! * height,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: SizedBox(
      width: SizeConfigure.widthConfig! * width,
    ),
  );
}
