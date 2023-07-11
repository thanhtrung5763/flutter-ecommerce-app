import 'package:final_project/views/sign_up/components/sign_up_footer.dart';
import 'package:final_project/views/sign_up/components/sign_up_form.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 96.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /* -- Section-1 [Header] -- */
            BigText(
              text: 'Sign up',
              size: 34.h,
            ),
            /* -- Section-2 [Form] -- */
            const SignUpForm(),
            /* -- Section-3 [Footer] -- */
            const SignUpFooter()
          ],
        ),
      ),
    );
  }
}
