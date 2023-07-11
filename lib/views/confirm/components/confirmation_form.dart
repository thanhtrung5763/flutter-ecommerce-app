import 'dart:async';

import 'package:final_project/utils/colors.dart';
import 'package:final_project/services/auth/bloc/auth_bloc.dart';
import 'package:final_project/widgets/button_icon_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmationForm extends StatefulWidget {
  const ConfirmationForm({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfirmationForm> createState() => _ConfirmationFormState();
}

class _ConfirmationFormState extends State<ConfirmationForm> {
  late final TextEditingController _confirmationCode;
  int secondsRemaining = 30;
  bool enableResend = false;
  late Timer timer;
  @override
  void initState() {
    _confirmationCode = TextEditingController();
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _confirmationCode.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Column(
        children: [
          TextFormField(
            controller: _confirmationCode,
            cursorColor: AppColors.black,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Confirmation Code',
              labelStyle: TextStyle(fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero, borderSide: BorderSide(color: AppColors.black, width: 1.5)),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ButtonIconText(
            text: 'SUBMIT',
            onPressed: () async {
              final confirmationCode = _confirmationCode.text;
              // final isSignUpComplete = await AuthRepository.confirmSignUp(
              //   username: widget.username,
              //   confirmationCode: confirmationCode,
              // );
              // if (isSignUpComplete) {
              //   print(await AuthRepository.isUserSignedIn());

              //   Navigator.of(context).pushNamedAndRemoveUntil(
              //       RouteHelper.homeRoute, (route) => false);
              // }
              context.read<AuthBloc>().add(AuthEventConfirmSignUp(confirmationCode));
            },
          ),
          TextButton(
            // style: TextButton.styleFrom(
            //   disabledBackgroundColor: AppColors.grey04,
            //   disabledForegroundColor: Colors.white,
            // ),
            onPressed: enableResend
                ? () async {
                    // final isSignUpComplete = await AuthRepository.confirmSignUp(
                    //   username: widget.username,
                    //   confirmationCode: confirmationCode,
                    // );
                    // if (isSignUpComplete) {
                    //   print(await AuthRepository.isUserSignedIn());

                    //   Navigator.of(context).pushNamedAndRemoveUntil(
                    //       RouteHelper.homeRoute, (route) => false);
                    // }
                    setState(() {
                      secondsRemaining = 30;
                      enableResend = false;
                    });
                    context.read<AuthBloc>().add(const AuthEventResendSignUpCode());
                  }
                : null,
            child: Text.rich(
              TextSpan(
                text: enableResend ? 'Don\'t receive the code? ' : 'Resend in ',
                style: const TextStyle(color: AppColors.black, fontWeight: FontWeight.w200),
                children: [
                  TextSpan(
                    text: enableResend ? 'Resend' : '${secondsRemaining}s',
                    style: const TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
