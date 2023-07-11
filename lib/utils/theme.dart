import 'package:final_project/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.whiteBackGround,
    fontFamily: 'metropolis',
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: AppColors.black),
      hintStyle: TextStyle(
        fontSize: 14,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      elevation: 0.2,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.black87),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black54),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(Colors.black87),
      fillColor: MaterialStateProperty.all(Colors.black87),
    ),
  );
}
