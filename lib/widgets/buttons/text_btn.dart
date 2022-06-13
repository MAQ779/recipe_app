import 'package:flutter/material.dart';
import 'package:recipe_app/constants/theme_constants.dart';

Widget textButton( String text, double fontSize ){
  return TextButton(child: Text(text, style: TextStyle(fontSize: fontSize, color: ThemeConst.lightTheme.primaryColor)),
    onPressed: () {  },);
}