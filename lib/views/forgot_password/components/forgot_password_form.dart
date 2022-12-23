import 'package:final_project/colors.dart';
import 'package:final_project/widgets/button_icon_text.dart';
import 'package:flutter/material.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          cursorColor: AppColors.black,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Email',
            labelStyle: TextStyle(fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(color: AppColors.black, width: 1.5)),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        ButtonIconText(
          text: 'SEND',
          onPressed: () {},
        ),
      ],
    );
  }
}
