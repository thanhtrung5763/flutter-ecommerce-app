import 'package:final_project/colors.dart';
import 'package:final_project/services/auth/auth_repository.dart';
import 'package:final_project/services/auth/bloc/auth_bloc.dart';
import 'package:final_project/services/auth/cubit/auth_cubit.dart';
import 'package:final_project/size_config.dart';
import 'package:final_project/views/confirm/confirmation_view.dart';
import 'package:final_project/widgets/button_icon_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late final TextEditingController _username;
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _username = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _email.dispose();
    _password.dispose();
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
            controller: _username,
            cursorColor: AppColors.black,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: tr('Name'),
              labelStyle: const TextStyle(fontSize: 14),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(color: AppColors.black, width: 1.5)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _email,
            cursorColor: AppColors.black,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: tr('Email'),
              labelStyle: const TextStyle(fontSize: 14),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(color: AppColors.black, width: 1.5)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _password,
            cursorColor: AppColors.black,
            obscureText: true,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: tr('Password'),
                labelStyle: const TextStyle(fontSize: 14),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(color: AppColors.black, width: 1.5)),
                suffixIcon: const IconButton(
                    onPressed: null, icon: Icon(Icons.remove_red_eye_sharp))),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Navigator.pop(context);
                context.read<AuthCubit>().showLogin();
              },
              child: SmallText(
                text: tr('Already have an account?'),
                size: getProportionateScreenWidth(14),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ButtonIconText(
            text: tr('SIGN UP'),
            onPressed: () async {
              final username = _username.text;
              final email = _email.text;
              final password = _password.text;
              context.read<AuthBloc>().add(AuthEventSignUp(username, email, password));
              // await AuthRepository.signUp(
              //   username: username,
              //   email: email,
              //   password: password,
              // );
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (_) => ConfirmationView(username: username),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}
