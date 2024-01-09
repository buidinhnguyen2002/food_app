import 'package:final_project/utils/colors.dart';
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: AppColors.white,
    primary: AppColors.primaryColor,
    secondary: AppColors.black,
    error: AppColors.red,
    onPrimary: Colors.white,
    onError: Colors.white,
    tertiary: AppColors.grey01,
    onBackground: AppColors.black,
    onTertiary: AppColors.grey02,
    surface: Color.fromARGB(20, 158, 158, 158),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: AppColors.black,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: TextStyle(
      color: AppColors.grey02,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: TextStyle(
      color: AppColors.grey02,
      fontSize: 12,
    ),
    titleLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: AppColors.black,
    ),
    titleMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: AppColors.black,
    ),
    titleSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppColors.black,
    ),
  ),
  dividerColor: const Color.fromARGB(93, 189, 189, 187),
);
ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: AppColors.black,
    primary: AppColors.primaryColor,
    secondary: AppColors.black,
    error: AppColors.red,
    onPrimary: Colors.white,
    onError: Colors.white,
    tertiary: AppColors.grey01,
    onBackground: AppColors.white,
    onTertiary: AppColors.grey02,
    surface: Color.fromARGB(20, 158, 158, 158),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: AppColors.white,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: TextStyle(
      color: AppColors.grey01,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: TextStyle(
      color: AppColors.grey01,
      fontSize: 12,
    ),
    titleLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: AppColors.white,
    ),
    titleMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: AppColors.white,
    ),
    titleSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppColors.white,
    ),
  ),
  dividerColor: const Color.fromARGB(93, 189, 189, 187),
  iconTheme: const IconThemeData(color: AppColors.white),
);
