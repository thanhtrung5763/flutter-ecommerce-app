import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/widgets/button_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SizeColorFavorite extends StatelessWidget {
  const SizeColorFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    var dropDownValue = Constants.lDropDown[0];

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.grey),
                borderRadius: BorderRadius.circular(10)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: dropDownValue,
                items: Constants.lDropDown.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? items) {
                  // setState(() {
                  //   dropDownValue = items!;
                  // });
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.grey),
                borderRadius: BorderRadius.circular(10)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: dropDownValue,
                items: Constants.lDropDown.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? items) {
                  // setState(() {
                  //   dropDownValue = items!;
                  // });
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        ButtonIcon.twoState(
          iconInActive: Icons.favorite_outline,
          iconActivated: Icons.favorite,
        ),
      ],
    );
  }
}
