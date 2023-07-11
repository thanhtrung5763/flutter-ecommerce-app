import 'package:final_project/utils/colors.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:flutter/material.dart';

class HorizontalOrLine extends StatelessWidget {
  const HorizontalOrLine({
    super.key,
    required this.label,
    required this.height,
  });

  final String label;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 15.0),
            child: Divider(
              color: AppColors.grey04,
              height: height,
            )),
      ),
      BigText(
        text: label,
        size: 14,
        color: AppColors.black.withOpacity(0.7),
      ),
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: Divider(
              color: AppColors.grey04,
              height: height,
            )),
      ),
    ]);
  }
}
