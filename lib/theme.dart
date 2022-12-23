import 'package:final_project/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.whiteBackGround,
    fontFamily: 'metropolis',
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: AppColors.black),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.whiteBackGround,
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: Colors.black87),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: Colors.black54),
  );
}

// TextTheme textTheme() {
//   return TextTheme(
//       headlineLarge: TextStyle(
//           color: AppColors.black, fontSize: 34, fontWeight: FontWeight.bold),
//       headlineMedium: TextStyle(
//           color: AppColors.black, fontSize: 24, fontWeight: FontWeight.bold),
//       headlineSmall: TextStyle(
//           color: AppColors.black, fontSize: 18, fontWeight: FontWeight.bold),
//       subtitle1: TextStyle(
//           color: AppColors.black, fontSize: 16, fontWeight: FontWeight.bold),
//       subtitle2: TextStyle(
//           color: AppColors.black, fontSize: 14, fontWeight: FontWeight.bold),
//       bodyText1: TextStyle(color: AppColors.black, fontSize: 16),
//       bodyText2: TextStyle(color: AppColors.black, fontSize: 14),
//       caption: TextStyle(color: AppColors.grey, fontSize: 11));
// }
