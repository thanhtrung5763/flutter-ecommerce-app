import 'package:final_project/utils/colors.dart';
import 'package:final_project/services/auth/cubit/auth_cubit.dart';
import 'package:final_project/widgets/horizontal_or_line.dart';
import 'package:final_project/widgets/logo_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            // SizedBox(
            //   height: 10.h,
            // ),
            // OutlinedButtonIconText(
            //   text: 'FACEBOOK',
            //   icon: FontAwesomeIcons.facebook,
            //   height: AppSizes.kHeightLarge,
            //   onPressed: () {},
            // ),
            SizedBox(
              height: 16.h,
            ),
            TextButton(
              onPressed: () {
                // Navigator.of(context).pushNamed(
                //     RouteHelper.signUpRoute);
                context.read<AuthCubit>().showSignUp();
              },
              child: const Text.rich(
                TextSpan(
                  text: 'Don\'t have an Account? ',
                  style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w200),
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
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
