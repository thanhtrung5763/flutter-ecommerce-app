import 'package:final_project/utils/colors.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/button_icon_text.dart';
import 'package:final_project/widgets/outlined_button_icon_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';

class CheckoutSuccessView extends StatelessWidget {
  const CheckoutSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Icon(
            Icons.check_circle,
            color: AppColors.green,
            size: 100,
          ),
        ),
        BigText(
          text: 'Thank you!\n',
          size: 18,
        ),
        const SizedBox(
          height: 10,
        ),
        SmallText(
          text: 'Your order has been placed.',
          size: 14,
        ),
        const SizedBox(
          height: 30,
        ),
        ButtonIconText(
          text: 'VIEW ORDER',
          onPressed: () {},
        ),
        const SizedBox(
          height: 8,
        ),
        OutlinedButtonIconText(
          text: 'BACK TO HOME',
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ],
    ));
  }
}
