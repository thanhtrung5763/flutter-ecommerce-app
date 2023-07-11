import 'package:final_project/services/auth/auth_repository.dart';
import 'package:final_project/services/auth/bloc/auth_bloc.dart';
import 'package:final_project/services/auth/cubit/auth_cubit.dart';
import 'package:final_project/size_config.dart';
import 'package:final_project/views/sign_up/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => AuthBloc(
          authRepo: context.read<AuthRepository>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: const Body(),
      ),
    );
  }
}
