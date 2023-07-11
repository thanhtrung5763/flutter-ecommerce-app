// Custom text widget to reuse multiple times

import 'package:final_project/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

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
      this.size = 20,
      this.maxLines = 1,
      this.overflow = TextOverflow.ellipsis,
      this.fontWeight = FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr(),
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: size.sp,
        fontWeight: fontWeight,
      ),
      overflow: overflow,
    );
  }
}
