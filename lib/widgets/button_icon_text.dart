import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/sizes.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonIconText extends StatelessWidget {
  IconData? icon;
  final String text;
  VoidCallback? onPressed;

  OutlinedBorder shape;
  Color backgroundColor;
  double iconSize;
  double textSize;
  double? width;
  double height;
  ButtonIconText({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.iconSize = 13,
    this.textSize = AppSizes.kTextSizeMedium,
    this.width = 343,
    this.height = AppSizes.kHeightMedium,
    this.shape = const RoundedRectangleBorder(),
    this.backgroundColor = AppColors.black,
  });

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? SizedBox(
            width: width?.w,
            height: height.h,
            child: ElevatedButton.icon(
              onPressed: onPressed,
              label: BigText(
                text: text,
                color: AppColors.white,
                size: textSize.h,
              ),
              icon: Icon(
                icon,
                size: textSize.h,
              ),
              // style: ButtonStyle(
              //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //     RoundedRectangleBorder(
              //       borderRadius:
              //           BorderRadius.circular(getProportionateScreenHeight(30)),
              //     ),
              //   ),
              //   backgroundColor:
              //       MaterialStateProperty.all<Color>(AppColors.redPrimary),
              // ),
              style: ElevatedButton.styleFrom(backgroundColor: backgroundColor, shape: shape),
            ),
          )
        : SizedBox(
            width: width?.w,
            height: height.h,
            child: ElevatedButton(
              onPressed: onPressed,
              // style: ButtonStyle(
              //     // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //     //   RoundedRectangleBorder(
              //     //     borderRadius: BorderRadius.circular(
              //     //         getProportionateScreenHeight(25)),
              //     //   ),
              //     // ),

              //     backgroundColor:
              //         MaterialStateProperty.all<Color>(AppColors.redPrimary)),
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  disabledBackgroundColor: AppColors.grey04,
                  disabledForegroundColor: Colors.white,
                  backgroundColor: backgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                  shape: shape),
              child: BigText(
                text: text,
                color: AppColors.white,
                size: textSize.h,
              ),
            ),
          );
  }
}
