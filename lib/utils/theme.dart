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
  colorScheme: const ColorScheme.dark(
    background: AppColors.black,
  ),
);


// class Themes {
//   static final light = ThemeData.light().copyWith(
//     textTheme: lightTextTheme,
//     // colorScheme: ThemeData.light().colorScheme.copyWith(secondary: ),
//     primaryColor: AppColors.primaryColor,
//     primaryColorLight: ,
//     primaryColorDark: cBlack,
//     scaffoldBackgroundColor: cSnow,
//     backgroundColor: cWhite,
//     toggleableActiveColor: cAccent,
//     secondaryHeaderColor: cSlateGray,
//     dividerColor: cGainsboro,
//     focusColor: cAccent,
//     bottomNavigationBarTheme:
//         const BottomNavigationBarThemeData(backgroundColor: cWhite, selectedItemColor: cAccent, unselectedItemColor: cSlateGray),
//     buttonTheme: const ButtonThemeData(buttonColor: cAccent, disabledColor: cSlateGray),
//     //textSelectionTheme: const TextSelectionThemeData(selectionColor: cDeepCarminePink),
//   );

//   static final lightTextTheme = TextTheme(
//     titleSmall: GoogleFonts.dmSans(fontWeight: FontWeight.bold, color: cCharleston, fontSize: Dimens.titleFontSizeSmall),
//     labelSmall: GoogleFonts.poppins(fontWeight: FontWeight.normal, color: cSlateGray, fontSize: Dimens.regularFontSizeSmall),
//     bodyLarge: GoogleFonts.karla(fontWeight: FontWeight.bold, color: cCharleston, fontSize: Dimens.titleFontSizeSmall),
//     //for button
//     labelLarge: GoogleFonts.dmSans(fontWeight: FontWeight.bold, color: cWhite, fontSize: Dimens.buttonFontSize),
//     //For TextField
//     bodyMedium: GoogleFonts.karla(fontWeight: FontWeight.normal, color: cCharleston, fontSize: Dimens.regularFontSizeMid),
//   );

//   static final dark = ThemeData.dark().copyWith(
//     textTheme: darkTextTheme,
//     colorScheme: ThemeData.light().colorScheme.copyWith(secondary: cAccent),
//     primaryColor: cWhite,
//     primaryColorLight: cSnow,
//     primaryColorDark: cGainsboro,
//     backgroundColor: cOnyx,
//     scaffoldBackgroundColor: cCharleston,
//     toggleableActiveColor: cAccent,
//     secondaryHeaderColor: cSlateGray,
//     dividerColor: cGainsboro,
//     focusColor: cAccent,
//     bottomNavigationBarTheme:
//         const BottomNavigationBarThemeData(backgroundColor: cSonicSilver, selectedItemColor: cAccent, unselectedItemColor: cSnow),
//     buttonTheme: const ButtonThemeData(buttonColor: cAccent, disabledColor: cSlateGray),
//   );

//   static final darkTextTheme = TextTheme(
//     titleSmall: GoogleFonts.dmSans(fontWeight: FontWeight.bold, color: cWhite, fontSize: Dimens.titleFontSizeSmall),
//     labelSmall: GoogleFonts.poppins(fontWeight: FontWeight.normal, color: cSonicSilver, fontSize: Dimens.regularFontSizeSmall),
//     bodyLarge: GoogleFonts.karla(fontWeight: FontWeight.bold, color: cWhite, fontSize: Dimens.titleFontSizeSmall),
//     //for button
//     labelLarge: GoogleFonts.dmSans(fontWeight: FontWeight.bold, color: cWhite, fontSize: Dimens.buttonFontSize),
//     //For TextField
//     bodyMedium: GoogleFonts.karla(fontWeight: FontWeight.normal, color: cWhite, fontSize: Dimens.regularFontSizeMid),
//   );
// }