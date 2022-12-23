import 'package:final_project/colors.dart';
import 'package:final_project/size_config.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ButtonIconText extends StatelessWidget {
  IconData? icon;
  final String text;
  final VoidCallback onPressed;

  OutlinedBorder? shape;
  Color backgroundColor;
  double iconSize;
  double textSize;
  double width;
  double height;
  ButtonIconText(
      {super.key,
      this.icon,
      this.iconSize = 13,
      this.textSize = 14,
      this.width = 343,
      this.height = 48,
      this.shape,
      this.backgroundColor = AppColors.redPrimary,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? SizedBox(
            width: width == 343 ? getProportionateScreenWidth(width) : width,
            height:
                height == 48 ? getProportionateScreenHeight(height) : height,
            child: ElevatedButton.icon(
              onPressed: onPressed,
              label: BigText(
                text: text,
                color: AppColors.white,
                size: getProportionateScreenWidth(textSize),
              ),
              icon: Icon(
                icon,
                size: getProportionateScreenWidth(iconSize),
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
              style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor, shape: shape),
            ),
          )
        : SizedBox(
            width: width == 343 ? getProportionateScreenWidth(width) : width,
            height:
                height == 48 ? getProportionateScreenHeight(height) : height,
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
                  backgroundColor: backgroundColor,
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                  shape: shape),
              child: BigText(
                text: text,
                color: AppColors.white,
                size: getProportionateScreenWidth(textSize),
              ),
            ),
          );
  }
}
