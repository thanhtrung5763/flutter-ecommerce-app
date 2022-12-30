import 'package:final_project/colors.dart';
import 'package:final_project/widgets/outlined_button_icon_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUpFooter extends StatelessWidget {
  const SignUpFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('OR').tr(),
        const SizedBox(
          height: 20,
        ),
        OutlinedButtonIconText(
          text: SmallText(
            text: tr('Sign-up with Google'),
            color: AppColors.black,
            size: 14,
          ),
          icon: FontAwesomeIcons.google,
          onPressed: () {},
        ),
        const SizedBox(
          height: 10,
        ),
        OutlinedButtonIconText(
          text: SmallText(
            text: tr('Sign-up with Facebook'),
            color: AppColors.black,
            size: 14,
          ),
          icon: FontAwesomeIcons.facebook,
          onPressed: () {},
        ),
      ],
    );
  }
}
