import 'package:final_project/views/confirm/components/confirmation_form.dart';
import 'package:final_project/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 64.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /* -- Section-1 [Header] -- */
              BigText(
                text: 'Confirmation',
                size: 34.h,
              ),
              SizedBox(
                height: 32.h,
              ),
              /* -- Section-2 [Form] -- */
              const ConfirmationForm(),
              /* -- Section-3 [Footer] -- */
            ],
          ),
        ),
      ),
    );
  }
}
