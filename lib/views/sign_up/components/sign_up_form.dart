import 'package:final_project/utils/colors.dart';
import 'package:final_project/services/auth/bloc/auth_bloc.dart';
import 'package:final_project/services/auth/cubit/auth_cubit.dart';
import 'package:final_project/widgets/button_icon_text.dart';
import 'package:final_project/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  bool _passwordVisible = false;

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
            controller: _email,
            cursorColor: AppColors.black,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Email',
              labelStyle: TextStyle(fontSize: 14.sp),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero, borderSide: BorderSide(color: AppColors.black, width: 1.5.w)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _password,
            cursorColor: AppColors.black,
            obscureText: !_passwordVisible,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Password',
              labelStyle: const TextStyle(fontSize: 14),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
              ),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.zero, borderSide: BorderSide(color: AppColors.black, width: 1.5)),
              suffixIcon: IconButton(
                  color: AppColors.grey,
                  splashRadius: 16,
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  icon: Icon(!_passwordVisible ? Icons.visibility : Icons.visibility_off)),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Navigator.pop(context);
                context.read<AuthCubit>().showLogin();
              },
              child: SmallText(
                text: 'Already have an account?',
                size: 12,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          ButtonIconText(
            text: 'SIGN UP',
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
