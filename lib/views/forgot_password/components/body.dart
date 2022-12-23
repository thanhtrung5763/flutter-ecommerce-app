import 'package:final_project/size_config.dart';
import 'package:final_project/views/forgot_password/components/forgot_password_form.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* -- Section-1 [Header] -- */
              SizedBox(
                height: getProportionateScreenWidth(56.5),
              ),
              BigText(
                text: 'Forgot password',
                size: getProportionateScreenWidth(34),
              ),
              SizedBox(
                height: getProportionateScreenWidth(56.5),
              ),
              SmallText(
                text:
                    'Please enter your email address. You will receive a link to create a new password via email',
              ),
              SizedBox(
                height: getProportionateScreenWidth(10),
              ),
              /* -- Section-2 [Form] -- */
              ForgotPasswordForm(),
              SizedBox(
                height: getProportionateScreenWidth(30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
