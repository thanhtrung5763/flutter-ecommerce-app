import 'package:final_project/widgets/horizontal_or_line.dart';
import 'package:final_project/widgets/logo_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpFooter extends StatelessWidget {
  const SignUpFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HorizontalOrLine(label: 'OR', height: 36),
        SizedBox(
          height: 8.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoContainer(
                onTap: () {},
                backgroundImage: Image.asset(
                  'assets/icons/facebook.png',
                ).image),
            SizedBox(
              width: 16.h,
            ),
            LogoContainer(
                onTap: () {},
                backgroundImage: Image.asset(
                  'assets/icons/google.png',
                ).image),
          ],
        ),
        // OutlinedButtonIconText(
        //   text: 'GOOGLE',
        //   icon: FontAwesomeIcons.google,
        //   height: AppSizes.kHeightLarge,
        //   onPressed: () {},
        // ),
        // const SizedBox(
        //   height: 10,
        // ),
        // OutlinedButtonIconText(
        //   text: 'FACEBOOK',
        //   icon: FontAwesomeIcons.facebook,
        //   height: AppSizes.kHeightLarge,
        //   onPressed: () {},
        // ),
      ],
    );
  }
}
