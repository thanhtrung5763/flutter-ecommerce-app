import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/sizes.dart';
import 'package:final_project/widgets/button_icon_text.dart';
import 'package:final_project/widgets/outlined_button_icon_text.dart';
import 'package:flutter/material.dart';

class TestButtonSize extends StatelessWidget {
  const TestButtonSize({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                OutlinedButtonIconText(
                    width: null,
                    colorBorderSide: AppColors.green,
                    height: AppSizes.kHeightTiny,
                    text: 'ADD TO BAG',
                    textSize: AppSizes.kTextSizeTiny,
                    onPressed: () async {}),
                const SizedBox(
                  height: 8,
                ),
                OutlinedButtonIconText(
                    width: null, height: AppSizes.kHeightSmall, text: 'CHECKOUT', onPressed: () async {}),
                const SizedBox(
                  height: 8,
                ),
                OutlinedButtonIconText(text: 'MEDIUM', onPressed: () async {}),
                const SizedBox(
                  height: 8,
                ),
                OutlinedButtonIconText(
                    height: AppSizes.kHeightLarge,
                    text: 'LARGE',
                    textSize: AppSizes.kTextSizeLarge,
                    onPressed: () async {}),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButtonIconText(
                    icon: Icons.add, height: AppSizes.kHeightSmall, text: 'SMALL', onPressed: () async {}),
                const SizedBox(
                  height: 8,
                ),
                OutlinedButtonIconText(icon: Icons.add, text: 'MEDIUM', onPressed: () async {}),
                const SizedBox(
                  height: 8,
                ),
                OutlinedButtonIconText(
                    icon: Icons.add,
                    height: AppSizes.kHeightLarge,
                    text: 'LARGE',
                    textSize: AppSizes.kTextSizeLarge,
                    onPressed: () async {}),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonIconText(
                  height: AppSizes.kHeightTiny,
                  text: 'SMALL',
                  onPressed: () async {},
                  textSize: 10,
                ),
                const SizedBox(
                  height: 8,
                ),
                ButtonIconText(
                  height: AppSizes.kHeightSmall,
                  text: 'SMALL',
                  onPressed: () async {},
                  textSize: 12,
                ),
                const SizedBox(
                  height: 8,
                ),
                ButtonIconText(
                  height: AppSizes.kHeightMedium,
                  text: 'SMALL',
                  onPressed: () async {},
                  textSize: 12,
                ),
                const SizedBox(
                  height: 8,
                ),
                ButtonIconText(
                  height: AppSizes.kHeightLarge,
                  text: 'SMALL',
                  textSize: 14,
                  onPressed: () async {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
