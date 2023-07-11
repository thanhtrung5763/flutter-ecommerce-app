// Custom text widget to reuse multiple times

import 'package:final_project/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

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
      this.fontWeight = FontWeight.w400});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr(),
      style: TextStyle(
        color: color,
        fontSize: size.sp,
        height: height,
        fontWeight: fontWeight,
      ),
    );
  }
}
