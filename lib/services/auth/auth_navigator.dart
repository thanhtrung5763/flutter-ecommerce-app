import 'package:final_project/services/auth/cubit/auth_cubit.dart';
import 'package:final_project/views/confirm/confirmation_view.dart';
import 'package:final_project/views/login/login_view.dart';
import 'package:final_project/views/sign_up/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthPageState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state == AuthPageState.logIn)
              const MaterialPage(child: LoginView()),
            if (state == AuthPageState.signUp ||
                state == AuthPageState.confirmSignUp) ...[
              const MaterialPage(child: SignUpView()),
              if (state == AuthPageState.confirmSignUp)
                const MaterialPage(child: ConfirmationView()),
            ],
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
        // if (state == AuthPageState.logIn) {
        //   return LoginView();
        // } else if (state == AuthPageState.signUp) {
        //   return const SignUpView();
        // } else if (state == AuthPageState.confirmSignUp) {
        //   return const ConfirmationView();
        // } else {
        //   return Container();
        // }
      },
    );
  }
}
