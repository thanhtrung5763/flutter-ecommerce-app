// Custom text widget to reuse multiple times

import 'package:final_project/colors.dart';
import 'package:final_project/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class BigText extends StatelessWidget {
  final String text;
  Color? color;
  double size;
  int maxLines;
  TextOverflow overflow;
  FontWeight fontWeight;
  BigText(
      {super.key,
      required this.text,
      this.color = AppColors.black, // signColor
      this.size = 0,
      this.maxLines = 1,
      this.overflow = TextOverflow.ellipsis,
      this.fontWeight = FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
          color: color,
          fontSize: size == 0 ? getProportionateScreenWidth(20) : size,
          fontWeight: fontWeight),
      overflow: overflow,
    );
  }
}
