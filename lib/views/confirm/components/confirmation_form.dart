import 'package:final_project/colors.dart';
import 'package:final_project/services/auth/bloc/auth_bloc.dart';
import 'package:final_project/services/auth/cubit/auth_cubit.dart';
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
  @override
  void initState() {
    _confirmationCode = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _confirmationCode.dispose();
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
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(color: AppColors.black, width: 1.5)),
            ),
          ),
          const SizedBox(
            height: 10,
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
              context
                  .read<AuthBloc>()
                  .add(AuthEventConfirmSignUp(confirmationCode));

            },
          ),
        ],
      ),
    );
  }
}
