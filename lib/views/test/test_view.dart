import 'package:final_project/colors.dart';
import 'package:final_project/constants.dart';
import 'package:final_project/size_config.dart';
import 'package:final_project/widgets/button_icon.dart';
import 'package:final_project/widgets/button_icon_text.dart';
import 'package:final_project/widgets/outlined_button_icon_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  var dropDownValue = Constants.lDropDown[0];
  bool value = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            top: getProportionateScreenHeight(106),
            left: getProportionateScreenWidth(16),
            right: getProportionateScreenWidth(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonIcon.twoState(
                iconInActive: Icons.favorite_outline,
                iconActivated: Icons.favorite,
              ),
              ButtonIcon(
                iconInActive: Icons.shopping_bag,
                iconColorInActive: AppColors.white,
                backgroundColorInActive: AppColors.redPrimary,
              ),
              ButtonIcon(
                iconInActive: Icons.add,
                iconColorInActive: AppColors.black,
                backgroundColorInActive: AppColors.white,
              ),
              ButtonIconText(
                text: 'LOGIN',
                onPressed: () {},
              ),
              ButtonIconText(
                text: 'Write a review',
                icon: Icons.edit,
                textSize: 11,
                width: getProportionateScreenWidth(128),
                height: getProportionateScreenHeight(36),
                shape: StadiumBorder(),
                onPressed: () {},
              ),
              ButtonIconText(
                text: 'Tag',
                textSize: 14,
                width: getProportionateScreenWidth(100),
                height: getProportionateScreenHeight(40),
                shape: StadiumBorder(),
                onPressed: () {},
              ),
              ButtonIconText(
                text: '-20%',
                textSize: 11,
                width: getProportionateScreenWidth(40),
                height: getProportionateScreenHeight(24),
                shape: StadiumBorder(),
                onPressed: () {},
              ),
              Chip(
                label: SmallText(
                  text: '-20%',
                  size: 11,
                  color: AppColors.white,
                ),
                backgroundColor: AppColors.redPrimary,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(2),
                        bottomRight: Radius.circular(2))),
              ),
              OutlinedButtonIconText(
                  text: SmallText(
                    text: 'OUTLINE',
                    color: AppColors.black,
                    size: 14,
                  ),
                  onPressed: () {}),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
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
                            setState(() {
                              dropDownValue = items!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
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
                            setState(() {
                              dropDownValue = items!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ButtonIcon.twoState(
                    iconInActive: Icons.favorite_outline,
                    iconActivated: Icons.favorite,
                  ),
                ],
              ),
              Checkbox(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                activeColor: AppColors.redPrimary,
                value: this.value,
                onChanged: (value) {
                  setState(() {
                    this.value = value!;
                  });
                },
              ),
              Container(
                width: 44,
                height: 44,
                padding: EdgeInsets.all(2),
                decoration: ShapeDecoration(
                  shape: CircleBorder(
                    side: BorderSide(width: 1, color: AppColors.redPrimary),
                  ),
                ),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: ShapeDecoration(
                      shape: CircleBorder(), color: AppColors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
