import 'package:final_project/utils/colors.dart';
import 'package:final_project/services/auth/bloc/auth_bloc.dart';
import 'package:final_project/widgets/button_icon_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  bool _passwordVisible = false;
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
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Name',
                labelStyle: TextStyle(fontSize: 14.sp),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero, borderSide: BorderSide(color: AppColors.black, width: 1.5.w)),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextFormField(
              controller: _password,
              obscureText: !_passwordVisible,
              cursorColor: AppColors.black,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Password',
                  labelStyle: TextStyle(fontSize: 14.sp),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero, borderSide: BorderSide(color: AppColors.black, width: 1.5.w)),
                  suffixIcon: IconButton(
                      color: AppColors.grey,
                      splashRadius: 16,
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      icon: Icon(!_passwordVisible ? Icons.visibility : Icons.visibility_off))),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: SmallText(
                  text: 'Forgot password?',
                  size: 12,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            ButtonIconText(
              text: 'LOGIN',
              onPressed: () async {
                // context.read<AuthBloc>().add(const AuthEventLogOut());
                final username = _username.text;
                final password = _password.text;
                context.read<AuthBloc>().add(AuthEventLogIn(username, password));
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
