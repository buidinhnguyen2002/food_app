import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF1BAC4B);
  static const Color pastelGreen = Color(0xFFE7F1E9);
  static const Color orange = Color(0xFFFEA121);
  static const Color pink = Color(0xFFFF7589);
  static const Color blue = Color(0xFF3E7EFF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color.fromARGB(255, 0, 0, 0);
  static const Color pastelPurple = Color(0xFFDE9FFE);
  static const Color yellow = Color(0xFFFE9F1A);
  static const Color grey = Color(0xFF535861);
  static const Color lightGrey = Color.fromARGB(255, 246, 243, 243);
  static const Color paleGray = Color(0xFFEFEFED);
  static const Color grey01 = Color(0xFFBDBDBB);
  static const Color grey02 = Color(0xFF626162);
  static const Color red = Color(0xFFF75555);
  static const Color green = Color.fromARGB(255, 25, 153, 68);
  static const Color background = Color(0xFFEEEEEF);
}

const Color cOrange = Color(0xFFFFA400);

const List<Color> bgGradientColors = <Color>[
  Color(0xFFFEEEAE),
  Color(0xFFFEEA9A),
  Color(0xFFFDE686),
  Color(0xFFFDE272),
  Color(0xFFFDDD5D),
  Color(0xFFfcd535)
];
const List<Color> bgGradientDarkColors = <Color>[
  Color(0xFFE0DDD0),
  Color(0xFFD1CCB9),
  Color(0xFFC1BBA1),
  Color(0xFFB2AA8A),
  Color(0xFFA39973),
  Color(0xFF847744)
];

int getColorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');
  if (hexColor.length == 6) {
    hexColor = 'FF$hexColor';
  }
  return int.parse(hexColor, radix: 16);
}
