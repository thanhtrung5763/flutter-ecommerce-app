import 'package:final_project/utils/colors.dart';
import 'package:flutter/material.dart';

class LogoContainer extends StatelessWidget {
  final ImageProvider<Object> backgroundImage;
  final Function()? onTap;
  const LogoContainer({super.key, required this.backgroundImage, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.grey04)),
        child: CircleAvatar(
          radius: 16,
          backgroundColor: Colors.transparent,
          backgroundImage: backgroundImage,
        ),
      ),
    );
  }
}