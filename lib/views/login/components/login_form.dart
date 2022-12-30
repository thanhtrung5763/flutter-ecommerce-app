import 'package:final_project/colors.dart';
import 'package:final_project/services/auth/bloc/auth_bloc.dart';
import 'package:final_project/size_config.dart';
import 'package:final_project/widgets/button_icon_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController _username;
  late final TextEditingController _password;

  @override
  void initState() {
    _username = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          children: [
            TextFormField(
              controller: _username,
              cursorColor: AppColors.black,
              decoration:  InputDecoration(
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
              controller: _password,
              obscureText: true,
              cursorColor: AppColors.black,
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
                      borderSide:
                          BorderSide(color: AppColors.black, width: 1.5)),
                  suffixIcon: const IconButton(
                      onPressed: null, icon: Icon(Icons.remove_red_eye_sharp))),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: SmallText(
                  text: tr('Forgot password?'),
                  size: getProportionateScreenWidth(14),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonIconText(
              text: tr('LOGIN'),
              onPressed: () async {
                final username = _username.text;
                final password = _password.text;
                context
                    .read<AuthBloc>()
                    .add(AuthEventLogIn(username, password));
                // await AuthRepository.logIn(
                //   username: username,
                //   password: password,
                // );
                // final isUserSignedIn = await AuthRepository.isUserSignedIn();
                // if (isUserSignedIn) {
                //   print(await AuthRepository.isUserSignedIn());
                //   Navigator.of(context).pushNamedAndRemoveUntil(
                //       RouteHelper.homeRoute, (route) => false);
                // }
              },
            ),
          ],
        );
      },
    );
  }
}
