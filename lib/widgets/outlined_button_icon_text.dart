import 'package:final_project/colors.dart';
import 'package:final_project/size_config.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OutlinedButtonIconText extends StatelessWidget {
  IconData? icon;
  final Widget text;
  final GestureTapCallback onPressed;
  double width;
  double height;
  double borderWidth;
  Color colorBorderSide;
  OutlinedBorder? shape;

  OutlinedButtonIconText({
    super.key,
    this.icon,
    this.width = 343,
    this.height = 48,
    this.borderWidth = 1.5,
    this.colorBorderSide = Colors.black,
    this.shape,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? SizedBox(
            width: width == 343 ? getProportionateScreenWidth(width) : width,
            height:
                height == 48 ? getProportionateScreenHeight(height) : height,
            child: OutlinedButton.icon(
              onPressed: onPressed,
              label: text,
              icon: FaIcon(
                icon,
                color: AppColors.black,
              ),
              style: OutlinedButton.styleFrom(
                  // shape: StadiumBorder(),
                  backgroundColor: AppColors.white,
                  shape: shape,
                  side: BorderSide(color: colorBorderSide, width: borderWidth)),
            ),
          )
        : SizedBox(
            width: width == 343 ? getProportionateScreenWidth(width) : width,
            height:
                height == 48 ? getProportionateScreenHeight(height) : height,
            child: OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                  // shape: StadiumBorder(),
                  backgroundColor: AppColors.white,
                  shape: shape,
                  side: BorderSide(color: colorBorderSide, width: borderWidth)),
              child: text,
            ),
          );
  }
}
