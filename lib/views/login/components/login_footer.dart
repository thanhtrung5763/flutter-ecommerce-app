import 'package:final_project/colors.dart';
import 'package:final_project/services/auth/cubit/auth_cubit.dart';
import 'package:final_project/widgets/outlined_button_icon_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthPageState>(
      builder: (context, state) {
        return Column(
          children: [
            const Text('OR'),
            const SizedBox(
              height: 20,
            ),
            OutlinedButtonIconText(
              text: SmallText(
                text: 'Sign-in with Google',
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
                text: 'Sign-in with Facebook',
                color: AppColors.black,
                size: 14,
              ),
              icon: FontAwesomeIcons.facebook,
              onPressed: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                // Navigator.of(context).pushNamed(
                //     RouteHelper.signUpRoute);
                context.read<AuthCubit>().showSignUp();
              },
              child: Text.rich(
                TextSpan(
                  text: 'Don\'t have an Account? ',
                  style: TextStyle(color: AppColors.black),
                  children: const [
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(color: AppColors.redPrimary),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
