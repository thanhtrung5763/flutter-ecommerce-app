import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/sizes.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OutlinedButtonIconText extends StatelessWidget {
  IconData? icon;
  final String text;
  VoidCallback? onPressed;
  double textSize;
  double iconSize;
  double? width;
  double height;
  double borderWidth;
  Color colorBorderSide;
  OutlinedBorder shape;

  OutlinedButtonIconText({
    super.key,
    this.icon,
    this.iconSize = 20,
    this.textSize = AppSizes.kTextSizeMedium,
    this.width = 343,
    this.height = AppSizes.kHeightMedium,
    this.borderWidth = 2,
    this.colorBorderSide = AppColors.grey04,
    this.shape = const RoundedRectangleBorder(),
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? SizedBox(
            width: width?.w,
            height: height.h,
            child: OutlinedButton.icon(
              onPressed: onPressed,
              label: BigText(
                text: text,
                size: textSize.h,
              ),
              icon: FaIcon(
                icon,
                color: AppColors.black,
                size: iconSize.h,
              ),
              style: OutlinedButton.styleFrom(
                  // shape: StadiumBorder(),
                  backgroundColor: AppColors.white,
                  shape: shape,
                  side: BorderSide(color: colorBorderSide, width: borderWidth)),
            ),
          )
        : SizedBox(
            width: width?.w,
            height: height.h,
            child: OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  // shape: StadiumBorder(),
                  backgroundColor: AppColors.white,
                  shape: shape,
                  side: BorderSide(color: colorBorderSide, width: borderWidth)),
              child: BigText(
                text: text,
                size: textSize.h,
              ),
            ),
          );
  }
}
