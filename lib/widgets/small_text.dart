// Custom text widget to reuse multiple times

import 'package:final_project/colors.dart';
import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  Color? color;
  double size;
  double height;
  FontWeight fontWeight;
  SmallText(
      {super.key,
      required this.text,
      this.color = AppColors.black, // textColor
      this.size = 12,
      this.height = 1.2,
      this.fontWeight = FontWeight.w500});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        height: height,
        fontWeight: fontWeight,
      ),
    );
  }
}
