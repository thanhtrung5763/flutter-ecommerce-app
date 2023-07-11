import 'package:final_project/utils/colors.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppChip extends StatelessWidget {
  const AppChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
                label: SmallText(
                  text: '-20%',
                  size: 11,
                  color: AppColors.black,
                ),
                backgroundColor: AppColors.white,
                padding: EdgeInsets.zero,
                side: BorderSide(color: AppColors.grey, width: 1.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              );
  }
}