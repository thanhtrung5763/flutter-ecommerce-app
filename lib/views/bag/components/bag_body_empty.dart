import 'package:final_project/utils/colors.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/button_icon_text.dart';
import 'package:final_project/widgets/outlined_button_icon_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';

class BagBodyEmpty extends StatelessWidget {
  const BagBodyEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 280,
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.shopping_bag_outlined,
              size: 100,
            ),
            BigText(
              text: 'YOUR BAG IS EMPTY',
              size: 16,
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonIconText(
              text: 'VIEW SAVED ITEMS',
              onPressed: () {},
              height: 42,
            ),
            OutlinedButtonIconText(
              text: 'CONTINUE SHOPPING',
              onPressed: () {},
              height: 42,
            )
          ],
        ),
      ),
    );
  }
}
